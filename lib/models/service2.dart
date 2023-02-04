import 'package:repairity/models/workshop.dart';

class Service2 {
  Workshop workshop;
  String type = '';
  String name = '';
  String price = '';
  String costLabor = '';
  int index = 0;
  Service2({
    required this.index,
    required this.workshop,
    required this.type,
    required this.name,
    required this.price,
    required this.costLabor,
  });
}
