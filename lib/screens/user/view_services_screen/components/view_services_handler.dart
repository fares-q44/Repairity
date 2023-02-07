import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/service2.dart';
import '../../../../models/workshop.dart';

class ViewServicesHandler {
  Future<List<Service2>> fetchAndSetService(String title) async {
    final client = Supabase.instance.client;
    List<Service2> finishedServices = [];
    try {
      final fetchedServices =
          await client.rpc('get_service', params: {'giventype': title}) as List;
      print(fetchedServices);
      for (var element in fetchedServices) {
        finishedServices.add(
          Service2(
            index: element['id'],
            workshop: Workshop(
                rating: element['avg'] == null
                    ? 0
                    : (element['avg'] as double).toInt(),
                id: element['uid'],
                username: element['username'],
                lat: double.parse(element['lat']),
                lon: double.parse(element['lon'])),
            type: element['type'],
            name: element['name'],
            price: element['price'],
            costLabor: element['cost_labor'],
          ),
        );
      }
    } catch (e) {
      print(e);
    }

    return finishedServices;
  }
}
