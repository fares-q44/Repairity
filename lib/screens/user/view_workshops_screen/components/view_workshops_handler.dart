import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
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
        final fetchedPic = await client.storage
            .from('profile-pictures')
            .download(element['uid']);
        Uint8List imageInUnit8List = fetchedPic;
        final tempDir = await getTemporaryDirectory();
        File file =
            await File('${tempDir.path}/${element["uid"]}.png').create();
        file.writeAsBytesSync(imageInUnit8List);
        finishedWorkshops.add(
          Workshop(
            username: element['username'],
            lat: double.parse(element['lat']),
            lon: double.parse(element['lon']),
            profilePic: file,
          ),
        );
      }
      return finishedWorkshops;
    } catch (e) {
      rethrow;
    }
  }
}
