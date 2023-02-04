import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:repairity/models/chat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatHandler with ChangeNotifier {
  final currentId = Supabase.instance.client.auth.currentUser!.id;
  List<Chat> allChats = [];
  Future<void> fetchAndSetChats() async {
    allChats = [];
    try {
      final client = Supabase.instance.client;

      final fetchedChats =
          await client.from('chats').select('*') as List<dynamic>;
      for (var element in fetchedChats) {
        //try to merge the if statement with the sql query above

        if (element['first_participant'] == currentId ||
            element['second_participant'] == currentId) {
          Chat tempChat = Chat(
              chatId: element['chat_id'],
              firstPart: element['first_participant'],
              secondPart: element['second_participant']);
          if (allChats.contains(tempChat)) {
            continue;
          }
          allChats.add(tempChat);
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<Chat> initiateChat(String secondPart) async {
    try {
      final client = Supabase.instance.client;
      for (var element in allChats) {
        if (element.firstPart == currentId &&
                element.secondPart == secondPart ||
            element.firstPart == secondPart &&
                element.secondPart == currentId) {
          return element;
        }
      }

      ///Insert in the database and return the chat id
      final chatId = await client.from('chats').insert({
        'first_participant': currentId,
        'second_participant': secondPart
      }).select('chat_id') as List<dynamic>;
      allChats.add(Chat(
          chatId: chatId.first['chat_id'],
          firstPart: currentId,
          secondPart: secondPart));
      notifyListeners();
      return allChats.last;
    } catch (e) {
      rethrow;
    }
  }
}
