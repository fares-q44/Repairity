import 'package:repairity/models/Post.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewPostsHandler {
  Future<List<Post>> fetchAndSetPosts() async {
    try {
      final client = Supabase.instance.client;
      final List<Post> finishedPosts = [];
      final fetchedPosts = await client.from('posts').select(
              'id, owner_id, title, contact, details, owner_id, img_count')
          as List<dynamic>;
      for (var element in fetchedPosts) {
        finishedPosts.add(
          Post(
              id: element['id'],
              title: element['title'],
              contact: element['contact'],
              description: element['details'],
              imgCount: element['img_count'],
              ownerId: element['owner_id']),
        );
      }

      return finishedPosts;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
