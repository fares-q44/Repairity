import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/widgets/top_notch.dart';

import '../view_workshop_profile_screen/view_workshop_profile_screen.dart';
import 'components/view_services_handler.dart';

class ViewSingleServiceScreen extends StatelessWidget {
  const ViewSingleServiceScreen({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    final future = Provider.of<ViewServicesHandler>(context, listen: false)
        .fetchAndSetService(title);
    return Scaffold(
      body: Column(
        children: [
          TopNotch(withBack: true, withAdd: false),
          FutureBuilder(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.only(top: 2),
                    separatorBuilder: (context, index) => Container(
                      height: 2,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => ListTile(
                      selectedTileColor: Colors.lightBlueAccent,
                      tileColor: const Color.fromRGBO(0, 255, 255, 0.5),
                      leading: const Icon(
                        Icons.tire_repair_rounded,
                        size: 50,
                        color: Color.fromARGB(255, 236, 236, 236),
                      ),
                      title: Text(snapshot.data![index].workshop.username,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color.fromARGB(200, 247, 247, 140)),
                          textScaleFactor: 1.5),
                      trailing: Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: sHeight * 0.07,
                      ),
                      subtitle: Text(
                          "Name: ${snapshot.data![index].name}\nPrice: ${snapshot.data![index].price}\nCost: ${snapshot.data![index].costLabor}",
                          style: const TextStyle(
                              fontSize: 14, color: Colors.white)),
                      selected: true,
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewWorkshopProfileScreen(
                                  workshop: snapshot.data![index].workshop),
                            ));
                      },
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
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
