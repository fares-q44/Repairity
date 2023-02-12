// ignore_for_file: public_member_api_docs, sort_constructors_first

class Workshop {
  final String id;
  final String username;
  final double lat;
  final double lon;
  final int rating;
  final String contact;
  Workshop({
    required this.id,
    required this.username,
    required this.lat,
    required this.lon,
    required this.rating,
    required this.contact,
  });
}
