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
      rethrow;
    }
  }

  Future<void> editService(
    String id,
    String type,
    String name,
    String price,
    String costLabor,
  ) async {
    try {
      // TODO
      // Do the edit
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> deleteService(String id) async {
    try {
      // TODO
      // Do the delete
      return true;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Service>> getOwnServices() async {
    final client = Supabase.instance.client;
    final List<Service> userOwnServices = [];

    /*for (int index = 0; index < 10; index++) {
      Service tempService = Service(
          index: index,
          id: 'id-$index',
          type: _type(index),
          name: _type(index),
          price: 20.toString(),
          costLabor: 20.toString());
      userOwnServices.add(tempService);
    }
    return userOwnServices;*/

    final result = await client
        .from('services')
        .select('id, type, name, price, cost_labor')
        .eq('owner_id', client.auth.currentUser!.id) as List<dynamic>;

    if (result.isNotEmpty) {
      int index = 0;
      for (var element in result) {
        try {
          Service tempService = Service(
              index: index++,
              id: element['type'],
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

/*String _type(int index) {
    switch (index % 4) {
      case 0:
        return 'Oil';
      case 1:
        return 'Tires';
      case 2:
        return 'Brakes';
      case 3:
        return 'Anything';
      default:
        return '';
    }
  }*/
}
