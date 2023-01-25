import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/view_services_screen/components/view_services_handler.dart';

class ViewServicesScreen extends StatelessWidget {
  const ViewServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final future = Provider.of<ViewServicesHandler>(context, listen: false)
        .fetchAndSetServices();
    return Container();
    // return Column(
    //   children: [
    //     TopNotch(withBack: false, withAdd: false),
    //     Expanded(
    //       child: ListView.separated(
    //         separatorBuilder: (context, index) => Container(
    //           height: 2,
    //         ),
    //         itemCount: 4,
    //         itemBuilder: (context, index) => ListTile(
    //           selectedTileColor: Colors.lightBlueAccent,
    //           tileColor: const Color.fromRGBO(0, 255, 255, 0.5),
    //           // leading: const Icon(Icons.add),
    //           title: const Text('tire',
    //               style: TextStyle(
    //                   fontWeight: FontWeight.bold,
    //                   fontSize: 16,
    //                   color: Color.fromARGB(200, 247, 247, 140)),
    //               textScaleFactor: 1.5),
    //           trailing: LayoutBuilder(builder: (context, constraint) {
    //             return _icon('tire', constraint.biggest.height);
    //           }),
    //           subtitle: const Text(
    //               "Name: ${'tire'}\nPrice: ${'50'}\nCost: ${'50'}",
    //               style: TextStyle(fontSize: 14, color: Colors.white)),
    //           selected: true,
    //           onTap: () {},
    //         ),
    //       ),
    //     ),
    //     // FutureBuilder(
    //     //   future: future,
    //     //   builder: (context, snapshot) {
    //     //     if (snapshot.connectionState == ConnectionState.waiting) {
    //     //       return const CircularProgressIndicator();
    //     //     } else {
    //     //       print(snapshot.data);
    //     //       return Container();
    //     //     }
    //     //   },
    //     // )
    //   ],
    // );
  }
}

Widget _icon(String type, double mySize) {
  switch (type) {
    case 'Oil':
      return Icon(Icons.oil_barrel_outlined, color: Colors.white, size: mySize);
    /*return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/serviceMotorOil.png'),
      );*/
    case 'Tires':
      return Icon(Icons.tire_repair, color: Colors.white, size: mySize);
    case 'Brakes':
      return Icon(Icons.view_carousel, color: Colors.white, size: mySize);
    case 'Anything':
      return Icon(Icons.car_crash, color: Colors.white, size: mySize);
    default:
      return Icon(Icons.car_repair, color: Colors.white, size: mySize);
  }
}
