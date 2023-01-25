// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:repairity/models/workshop.dart';

class Comment {
  final String id;
  final Workshop workshop;
  final String postID;
  final int price;
  final int duration;
  final String createdAt;
  Comment({
    required this.workshop,
    required this.id,
    required this.postID,
    required this.price,
    required this.duration,
    required this.createdAt,
  });
}
