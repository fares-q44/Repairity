const GOOGLE_API_KEY = 'AIzaSyCPSRF4ZPMve6ZYgkZ3KHcooazHE6D5iEg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:W%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }

  // static Future<String> getPlaceAddress(double lat, double lng) async {
  //   final url = Uri.parse(
  //       'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lng&key=$GOOGLE_API_KEY');

  //   final response = await http.get(url);
  //   return jsonDecode(response.body)['results'][0]['formatted_address'];
  // }
  Future<void> saveLocation() async {}
}
