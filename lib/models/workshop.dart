// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

class Workshop {
  final String username;
  final double lat;
  final double lon;
  final File profilePic;
  Workshop({
    required this.username,
    required this.lat,
    required this.lon,
    required this.profilePic,
  });
}
