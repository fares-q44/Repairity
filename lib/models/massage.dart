import 'dart:io';

class Massage {
  final String massageId;
  final String chatId;
  final String senderId;
  final String receiverId;
  final String massageText;

  Massage(
      {required this.massageId,
      required this.chatId,
      required this.senderId,
      required this.receiverId,
      required this.massageText});
}
