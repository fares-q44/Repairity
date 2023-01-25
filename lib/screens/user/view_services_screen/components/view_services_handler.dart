import 'package:repairity/models/service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ViewServicesHandler {
  Future<List<Service>> fetchAndSetServices() async {
    final client = Supabase.instance.client;
    List<Service> finishedServices = [];
    final fetchedServices = await client
        .from('services')
        .select('id, owner_id, type, name, price, cost_labor') as List;
    for (var element in fetchedServices) {
      finishedServices.add(
        Service(
          index: element['id'],
          id: element['owner_id'],
          type: element['type'],
          name: element['name'],
          price: element['price'],
          costLabor: element['cost_labor'],
        ),
      );
    }
    return finishedServices;
  }
}
