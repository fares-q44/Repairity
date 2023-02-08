import 'package:repairity/models/review.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewSingleWorkshopHandler {
  final client = Supabase.instance.client;
  Future<void> submitReview(int rate, String comment, String workshopId) async {
    try {
      final username = await client
          .from('users')
          .select('username')
          .eq('uid', client.auth.currentUser!.id) as List;
      await client.from('reviews').insert(
        {
          'workshop_id': workshopId,
          'username': username[0]['username'],
          'stars': rate,
          'comment': comment,
        },
      );
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<List<Review>> fetchAndSetReviews(String workshopID) async {
    final List<Review> allReviews = [];
    try {
      final fetchedReviews = await client
          .from('reviews')
          .select('workshop_id, username, stars, comment')
          .eq('workshop_id', workshopID) as List<dynamic>;
      for (var element in fetchedReviews) {
        allReviews.add(
          Review(
            workshopID: element['workshop_id'],
            userName: element['username'],
            rate: element['stars'],
            comment: element['comment'],
          ),
        );
      }
      return allReviews;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
