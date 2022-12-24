import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:repairity/models/massage.dart';
import 'package:repairity/models/chat.dart';

class MassagesHandler {
  final client = Supabase.instance.client;
  Future<List<Massage>> fetchAndSetMassages(
      {required Chat selectedChat}) async {
    try {
      final chatId = selectedChat.chatId;
      final receiverId = selectedChat.secondPart;

      final List<Massage> finishedMassages =
          []; // list of all the massages that the user had sent and received
      final fetchedMassages = await client
          .from('massages')
          .select('massage_id, sender_id, created_at, massage_text')
          //return all the massages with the same chatId
          .eq('chat_id', chatId) as List<dynamic>;

      for (var element in fetchedMassages) {
        finishedMassages.add(
          //you might add the time
          Massage(
              massageId: element['massage_id'],
              chatId: chatId,
              senderId: element['sender_id'],
              receiverId: receiverId,
              massageText: element['massage_text']),
        );
      }
      return finishedMassages;
    } catch (e) {
      rethrow;
    }
  }

  void addMassage(
      {required String chatId,
      required String senderId,
      required String massageText}) async {
    try {
      //insert to the database
      await client.from('massages').insert({
        'chat_id': chatId,
        'sender_id': senderId,
        'massage_text': massageText
      });
    } catch (e) {
      rethrow;
    }
  }
}
