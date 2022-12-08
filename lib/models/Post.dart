// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class Post {
  String title = '';
  String contact = '';
  String description = '';
  List<File> images = [];
  Post({
    required this.title,
    required this.contact,
    required this.description,
    required this.images,
  });
}
