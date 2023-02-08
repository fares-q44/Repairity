import 'package:flutter/material.dart';
import 'package:repairity/screens/user/view_services_screen/view_single_service.dart';

class ServiceGridItem extends StatelessWidget {
  const ServiceGridItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewSingleServiceScreen(
                title: title,
              ),
            ));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 125, 254, 1),
            borderRadius: BorderRadius.circular(15)),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              _icon(title, sHeight * 0.13),
              Text(
                title,
                style: const TextStyle(fontSize: 24, color: Colors.white),
              )
            ],
          ),
        ),
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
