import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:repairity/models/chat.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatHandler with ChangeNotifier {
  final currentId = Supabase.instance.client.auth.currentUser!.id;
  final client = Supabase.instance.client;
  String myUsername = '';
  List<Chat> allChats = [];
  bool amIWorkshop = false;
  Future<void> fetchAndSetChats() async {
    allChats = [];
    try {
      List<dynamic> fetchedChats = [];

      await Future.wait([
        client.from('users').select('*').eq('uid', currentId),
        client.from('workshops').select('*').eq('uid', currentId),
        client.from('chats').select('*')
      ]).then((value) {
        fetchedChats = value[2];
        if (value[0].isEmpty) {
          myUsername = value[1][0]['username'];
          amIWorkshop = true;
        } else {
          myUsername = value[0][0]['username'];
          amIWorkshop = false;
        }
      });

      for (var element in fetchedChats) {
        //try to merge the if statement with the sql query above

        if (element['first_participant'] == currentId ||
            element['second_participant'] == currentId) {
          if (element['first_participant'] == currentId) {
            Chat tempChat = Chat(
                chatId: element['chat_id'],
                firstPartId: currentId,
                firstPartUsername: myUsername,
                secondPartId: element['second_participant'],
                secondPartUsername: element['second_participant_username']);
            if (allChats.contains(tempChat)) {
              continue;
            }
            allChats.add(tempChat);
          } else {
            Chat tempChat = Chat(
                chatId: element['chat_id'],
                firstPartId: currentId,
                firstPartUsername: myUsername,
                secondPartId: element['first_participant'],
                secondPartUsername: element['first_participant_username']);
            if (allChats.contains(tempChat)) {
              continue;
            }
            allChats.add(tempChat);
          }
        }
      }
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<Chat> initiateChat(String secondPart) async {
    try {
      for (var element in allChats) {
        if (element.firstPartId == currentId &&
                element.secondPartId == secondPart ||
            element.firstPartId == secondPart &&
                element.secondPartId == currentId) {
          return element;
        }
      }
      List temp = [];
      if (amIWorkshop) {
        temp = await client.from('users').select('*').eq('uid', secondPart);
      } else {
        temp = await client.from('workshops').select('*').eq('uid', secondPart);
      }
      print(temp);

      ///Insert in the database and return the chat id
      final chatId = await client.from('chats').insert({
        'first_participant': currentId,
        'first_participant_username': myUsername,
        'second_participant': secondPart,
        'second_participant_username': temp[0]['username'],
      }).select('chat_id') as List<dynamic>;
      allChats.add(
        Chat(
            chatId: chatId.first['chat_id'],
            firstPartId: currentId,
            firstPartUsername: myUsername,
            secondPartId: secondPart,
            secondPartUsername: temp[0]['username']),
      );
      notifyListeners();
      return allChats.last;
    } catch (e) {
      rethrow;
    }
  }
}
