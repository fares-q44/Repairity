import 'package:repairity/models/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewSinglePostHandler {
  Future<AppUser> getUser(String id) async {
    final result = await Supabase.instance.client
        .from('users')
        .select('uid, username')
        .eq('uid', id);
    print(result);
    return AppUser(id: result[0]['uid'], username: result[0]['username']);
  }
}
