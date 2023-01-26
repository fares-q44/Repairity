import 'package:repairity/models/app_user.dart';
import 'package:repairity/models/comment.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/workshop.dart';

class ViewSinglePostHandler {
  final client = Supabase.instance.client;
  Future<AppUser> getUser(String id) async {
    final result =
        await client.from('users').select('uid, username').eq('uid', id);
    return AppUser(id: result[0]['uid'], username: result[0]['username']);
  }

  Future<void> addComment(String postId, int price, int duration) async {
    try {
      await client.from('comments').insert({
        'workshop_id': client.auth.currentUser!.id,
        'post_id': postId,
        'price': price,
        'duration': duration,
      });
    } catch (e) {
      print(e);
    }
  }

  Future<List<Comment>> getPostComments(String postId) async {
    final List<Comment> fetchedComments = [];
    try {
      final result = await client
          .from('comments')
          .select('*, workshops(*)')
          .eq('post_id', postId) as List;

      for (var element in result) {
        final rate = await client
            .rpc('average_rate', params: {'wid': element['workshop_id']});
        fetchedComments.add(
          Comment(
            id: element['id'],
            workshop: Workshop(
                rating: rate ?? 0,
                id: element['workshop_id'],
                username: element['workshops']['username'],
                lat: double.parse(element['workshops']['lat']),
                lon: double.parse(element['workshops']['lon'])),
            postID: element['post_id'],
            price: element['price'],
            duration: element['duration'],
            createdAt: DateTime.parse(element['created_at']).toString(),
          ),
        );
      }
    } catch (e) {
      rethrow;
    }
    return fetchedComments;
  }
}
