import 'package:flutter/foundation.dart';
import 'package:repairity/models/Post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewPostsHandler with ChangeNotifier {
  List<Post> allPosts = [];
  Future<void> fetchAndSetPosts() async {
    allPosts = [];
    try {
      final client = Supabase.instance.client;
      final fetchedPosts = await client.from('posts').select(
              'id, owner_id, title, contact, details, owner_id, img_count, created_at')
          as List<dynamic>;
      for (var element in fetchedPosts) {
        Post tempPost = Post(
          id: element['id'],
          title: element['title'],
          contact: element['contact'],
          description: element['details'],
          imgCount: element['img_count'],
          ownerId: element['owner_id'],
          date: DateTime.parse(element['created_at']),
        );
        if (allPosts.contains(tempPost)) {
          continue;
        }
        allPosts.add(tempPost);
      }
      print(allPosts.length);
      notifyListeners();
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
