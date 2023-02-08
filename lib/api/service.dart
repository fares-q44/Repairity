import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/service.dart';

class Services {
  final client = Supabase.instance.client;
  String addedServiceId = '';

  Future<void> addService(
    String type,
    String name,
    String price,
    String costLabor,
  ) async {
    try {
      final insertedID = await client.from('services').insert({
        'owner_id': client.auth.currentUser!.id,
        'type': type,
        'name': name,
        'price': price,
        'cost_labor': costLabor,
      }).select('id');
      addedServiceId = insertedID[0]['id'].toString();
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<void> editService(
    int id,
    String type,
    String name,
    String price,
    String costLabor,
  ) async {
    try {
      await client.from('services').upsert({
        'owner_id': client.auth.currentUser!.id,
        'id': id,
        'type': type,
        'name': name,
        'price': price,
        'cost_labor': costLabor
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteService(int id) async {
    try {
      await client.from('services').delete().match({'id': id});
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Service>> getOwnServices() async {
    final client = Supabase.instance.client;
    final List<Service> userOwnServices = [];
    final result = await client
        .from('services')
        .select('*')
        .eq('owner_id', client.auth.currentUser!.id) as List<dynamic>;
    if (result.isNotEmpty) {
      int index = 0;
      for (var element in result) {
        try {
          Service tempService = Service(
              index: index++,
              id: element['id'],
              type: element['type'],
              name: element['name'],
              price: element['price'],
              costLabor: element['cost_labor']);
          userOwnServices.add(tempService);
        } catch (e) {
          print(e);
        }
      }
      return userOwnServices;
    }
    return [];
  }
}
