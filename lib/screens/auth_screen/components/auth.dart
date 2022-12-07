import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final auth = Supabase.instance.client.auth;
  final client = Supabase.instance.client;

  Future<void> authinticate(email, password, bool isLogin, bool isWorkshop,
      [username]) async {
    try {
      if (!isLogin) {
        // Sign user up
        await auth.signUp(email: email, password: password);
        await client.from('users').insert(
          [
            {
              'uid': auth.currentUser!.id,
              'username': username,
              'type': isWorkshop ? 'workshop' : 'user'
            }
          ],
        );
      } else {
        // sign user in
        await auth.signInWithPassword(email: email, password: password);
      }
    } catch (e) {
      rethrow;
    }
  }

  bool isLoggedIn() => Supabase.instance.client.auth.currentUser != null;
}
