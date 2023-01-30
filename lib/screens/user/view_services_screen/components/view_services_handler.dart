import 'package:repairity/models/workshop.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../models/service2.dart';

class ViewServicesHandler {
  Future<List<Service2>> fetchAndSetService(String title) async {
    final client = Supabase.instance.client;
    List<Service2> finishedServices = [];
    try {
      final fetchedServices = await client
          .from('services')
          .select('*, workshops(*)')
          .eq('type', title) as List;
      print(fetchedServices);
      for (var element in fetchedServices) {
        final rate = await client
            .rpc('average_rate', params: {'wid': element['workshops']['uid']});
        finishedServices.add(
          Service2(
            index: element['id'],
            workshop: Workshop(
                rating: rate ?? 0,
                id: element['workshops']['uid'],
                username: element['workshops']['username'],
                lat: double.parse(element['workshops']['lat']),
                lon: double.parse(element['workshops']['lon'])),
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
