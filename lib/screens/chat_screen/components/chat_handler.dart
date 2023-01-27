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

  // Future<String> getUsername(userId) async {
  //   final client = Supabase.instance.client;
  //   final user = await client
  //       .from('workshop, user')
  //       .select('username')
  //       .eq('uid', userId) as List<dynamic>;
  //   return user[0]['username'];
  // }
}
