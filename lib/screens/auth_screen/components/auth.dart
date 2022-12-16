import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Auth {
  final auth = Supabase.instance.client.auth;
  final client = Supabase.instance.client;

  Future<String> authinticate(email, password, bool isLogin, bool isWorkshop,
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
        return auth.currentUser!.id;
      } else {
        // sign user in
        await auth.signInWithPassword(email: email, password: password);
        return auth.currentUser!.id;
      }
    } catch (e) {
      rethrow;
    }
  }

  bool isLoggedIn() => Supabase.instance.client.auth.currentUser != null;

  static Future<void> uploadPhoto(XFile chosenImage) async {
    final client = Supabase.instance.client.storage;
    try {
      final File tempFile = File(chosenImage.path);
      await client
          .from('profile-pictures')
          .upload(Supabase.instance.client.auth.currentUser!.id, tempFile);
    } catch (e) {
      rethrow;
    }
  }
}
