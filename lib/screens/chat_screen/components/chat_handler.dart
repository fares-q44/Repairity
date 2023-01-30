import 'dart:core';

import 'package:repairity/models/chat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatHandler {
  final currentId = Supabase.instance.client.auth.currentUser!.id;

  Future<List<Chat>> fetchAndSetChats() async {
    try {
      final client = Supabase.instance.client;
      final List<Chat> finishedChats =
          []; // list of all the chats that the user had initiated
      final fetchedChats = await client.from('chats').select(
              'chat_id, first_participant, second_participant, created_at')
          as List<dynamic>;

      for (var element in fetchedChats) {
        //try to merge the if statement with the sql query above
        if (element['first_participant'] == currentId ||
            element['second_participant'] == currentId) {
          finishedChats.add(Chat(
              chatId: element['chat_id'],
              firstPart: element['first_participant'],
              secondPart: element['second_participant']));
        }
      }

      return finishedChats;
    } catch (e) {
      rethrow;
    }
  }

  Future<Chat> initiateChat(String secondPart) async {
    try {
      final client = Supabase.instance.client;
      final List<Chat> newChat = [];
      final fetchedChats = await client.from('chats').select(
              'chat_id, first_participant, second_participant, created_at')
          as List<dynamic>;

      for (var element in fetchedChats) {
        if (element['first_participant'] == currentId &&
                element['second_participant'] == secondPart ||
            element['first_participant'] == secondPart &&
                element['second_participant'] == currentId) {
          newChat.add(Chat(
              chatId: element['chat_id'],
              firstPart: element['first_participant'],
              secondPart: element['second_participant']));
          return newChat.first;
        }
      }

      ///Insert in the database and return the chat id
      final chatId = await client.from('chats').insert({
        'first_participant': currentId,
        'second_participant': secondPart
      }).select('chat_id') as List<dynamic>;
      newChat.add(Chat(
          chatId: chatId.first['chat_id'],
          firstPart: currentId,
          secondPart: secondPart));
      ;
      return newChat.first;
    } catch (e) {
      rethrow;
    }
  }
}
