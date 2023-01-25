import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/Post.dart';

class UserPosts {
  final client = Supabase.instance.client;
  String addedPostId = '';
  Future<void> addPost(
      String title, String contact, String details, int imgCount) async {
    try {
      final insertedID = await client.from('posts').insert({
        'owner_id': client.auth.currentUser!.id,
        'title': title,
        'contact': contact,
        'details': details,
        'img_count': imgCount
      }).select('id');
      addedPostId = insertedID[0]['id'];
    } catch (e) {
      rethrow;
    }
  }

  Future<void> uploadPhotos(List<XFile> chosenImages) async {
    final client = Supabase.instance.client.storage;
    int counter = 0;
    try {
      for (var element in chosenImages) {
        final File tempFile = File(element.path);
        await client
            .from('posts-images')
            .upload('$addedPostId/$counter.jpeg', tempFile);
        counter++;
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Post>> getOwnPosts() async {
    final client = Supabase.instance.client;
    final List<Post> userOwnPosts = [];

    final result = await client
        .from('posts')
        .select('id, title, contact, details, owner_id, img_count, created_at')
        .eq('owner_id', client.auth.currentUser!.id) as List<dynamic>;
    if (result.isNotEmpty) {
      for (var element in result) {
        try {
          Post tempPost = Post(
            id: element['id'],
            title: element['title'],
            contact: element['contact'],
            description: element['details'],
            imgCount: element['img_count'],
            ownerId: element['owner_id'],
            date: DateTime.parse(element['created_at']),
          );
          userOwnPosts.add(tempPost);
        } catch (e) {
          print(e);
          rethrow;
        }
      }
      return userOwnPosts;
    }
    return [];
  }
}
