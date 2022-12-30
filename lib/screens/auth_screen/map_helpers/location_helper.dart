const GOOGLE_API_KEY = 'AIzaSyCPSRF4ZPMve6ZYgkZ3KHcooazHE6D5iEg';

class LocationHelper {
  static String generateLocationPreviewImage(
      {required double latitude, required double longtitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longtitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Clabel:W%7C$latitude,$longtitude&key=$GOOGLE_API_KEY';
  }
}
