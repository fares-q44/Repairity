import 'package:supabase_flutter/supabase_flutter.dart';

const GOOGLE_API_KEY = 'AIzaSyCPSRF4ZPMve6ZYgkZ3KHcooazHE6D5iEg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:W%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }

  static Future<void> saveLocation(double lat, double lon) async {
    try {
      print('before');
      final client = Supabase.instance.client;
      await client.from('workshops-locations').insert({
        'id': client.auth.currentUser!.id,
        'latitude': lat,
        'longitude': lon
      });
      print('after');
    } catch (e) {
      rethrow;
    }
  }
}
