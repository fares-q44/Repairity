import 'package:repairity/models/workshop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewWorkshopHandler {
  Future<List<Workshop>> fetchAndSetWorkshops() async {
    try {
      final client = Supabase.instance.client;
      final List<Workshop> finishedWorkshops = [];
      final fetchedWorkshops =
          await client.rpc('get_workshops') as List<dynamic>;
      for (var element in fetchedWorkshops) {
        finishedWorkshops.add(
          Workshop(
            id: element['uid'],
            username: element['username'],
            lat: double.parse(element['lat']),
            lon: double.parse(element['lon']),
            rating:
                element['avg'] == null ? 0 : (element['avg'] as double).toInt(),
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
