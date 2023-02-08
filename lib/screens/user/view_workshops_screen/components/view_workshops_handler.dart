import 'package:repairity/models/workshop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewWorkshopHandler {
  Future<List<Workshop>> fetchAndSetWorkshops() async {
    try {
      final client = Supabase.instance.client;
      final List<Workshop> finishedWorkshops = [];
      final fetchedWorkshops = await client
          .from('workshops')
          .select('uid, username, lat, lon') as List<dynamic>;
      for (var element in fetchedWorkshops) {
        int totalRate = 0;
        final rate =
            await client.rpc('average_rate', params: {'wid': element['uid']});

        finishedWorkshops.add(
          Workshop(
            id: element['uid'],
            username: element['username'],
            lat: double.parse(element['lat']),
            lon: double.parse(element['lon']),
            rating: rate ?? 0,
          ),
        );
      }

      return finishedWorkshops;
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
