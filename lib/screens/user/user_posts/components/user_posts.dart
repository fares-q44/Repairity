import 'package:supabase_flutter/supabase_flutter.dart';

class UserPosts {
  final client = Supabase.instance.client;
  Future<void> addPost(
    String title,
    String contact,
    String details,
  ) async {
    try {
      await client.from('posts').insert({
        'owner_id': client.auth.currentUser!.id,
        'title': title,
        'contact': contact,
        'details': details,
      });
    } catch (e) {
      rethrow;
    }
  }
}
