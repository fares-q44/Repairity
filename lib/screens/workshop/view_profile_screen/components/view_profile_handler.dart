import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:repairity/models/workshop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewProfileHandler {
  final client = Supabase.instance.client;
  Future<Workshop> fetchAndSetWorkshop() async {
    final result = await client
        .from('workshops')
        .select('*')
        .eq('uid', client.auth.currentUser!.id);
    return Workshop(
      contact: result[0]['contact'],
      rating: 0,
      id: result[0]['uid'],
      username: result[0]['username'],
      lat: double.parse(result[0]['lat']),
      lon: double.parse(result[0]['lon']),
    );
  }

  Future<void> updateUsername(String username) async {
    await client
        .from('workshops')
        .update({'username': username}).eq('uid', client.auth.currentUser!.id);
  }

  Future<void> updateContact(String contact) async {
    await client
        .from('workshops')
        .update({'contact': contact}).eq('uid', client.auth.currentUser!.id);
  }

  Future<void> updateLocation(double lat, double lon) async {
    await client.from('workshops').update({'lat': lat, 'lon': lon}).eq(
        'uid', client.auth.currentUser!.id);
  }

  Future<void> updateImage(XFile image) async {
    final File tempFile = File(image.path);
    await client.storage
        .from('profile-pictures')
        .update(Supabase.instance.client.auth.currentUser!.id, tempFile);
  }
}
