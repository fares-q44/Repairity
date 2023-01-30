import 'package:repairity/models/workshop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewProfileHandler {
  Future<Workshop> fetchAndSetWorkshop() async {
    final client = Supabase.instance.client;
    final result = await client
        .from('workshops')
        .select('*')
        .eq('uid', client.auth.currentUser!.id);
    return Workshop(
      rating: 0,
      id: result[0]['uid'],
      username: result[0]['username'],
      lat: double.parse(result[0]['lat']),
      lon: double.parse(result[0]['lon']),
    );
  }
}
