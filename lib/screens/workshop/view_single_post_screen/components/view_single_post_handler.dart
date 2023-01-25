import 'package:repairity/models/app_user.dart';
import 'package:repairity/models/comment.dart';
import 'package:repairity/models/workshop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
          .select('id, workshop_id, post_id, price, duration, created_at')
          .eq('post_id', postId) as List;

      for (var element in result) {
        final fetchedworkshop = await client
            .from('workshops')
            .select('username, lat, lon')
            .eq('uid', element['workshop_id']);
        final rate = await client
            .rpc('average_rate', params: {'wid': element['workshop_id']});
        fetchedComments.add(
          Comment(
            id: element['id'],
            workshop: Workshop(
                rating: rate ?? 0,
                id: element['workshop_id'],
                username: fetchedworkshop[0]['username'],
                lat: double.parse(fetchedworkshop[0]['lat']),
                lon: double.parse(fetchedworkshop[0]['lon'])),
            postID: element['post_id'],
            price: element['price'],
            duration: element['duration'],
            createdAt: DateTime.parse(element['created_at']).toString(),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return fetchedComments;
  }
}
