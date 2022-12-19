import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/post.dart';

class UserPosts {
  final client = Supabase.instance.client;
  String addedPostId = '';
  Future<void> addPost(
    String title,
    String contact,
    String details,
  ) async {
    try {
      final insertedID = await client.from('posts').insert({
        'owner_id': client.auth.currentUser!.id,
        'title': title,
        'contact': contact,
        'details': details,
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
        .select('id, title, contact, details')
        .eq('owner_id', client.auth.currentUser!.id) as List<dynamic>;

    if (result.isNotEmpty) {
      for (var element in result) {
        try {
          Post tempPost = Post(
            title: element['title'],
            contact: element['contact'],
            description: element['details'],
            images: [],
          );
          userOwnPosts.add(tempPost);
        } catch (_) {
          rethrow;
        }
      }
      return userOwnPosts;
    }
    return [];
  }
  // Future<File> getPictures() async {
  //   try {
  //     final pic = await Supabase.instance.client.storage
  //         .from('posts-images')
  //         .download('6/0.jpeg');
  //     Uint8List imageInUnit8List = pic;
  //     final tempDir = await getTemporaryDirectory();
  //     File file = await File('${tempDir.path}/image.png').create();
  //     file.writeAsBytesSync(imageInUnit8List);
  //     return file;
  //   } catch (e) {
  //     print(e);
  //   }
  //   return File('');
  // }
}
