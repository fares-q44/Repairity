import 'package:flutter/material.dart';
import 'package:repairity/screens/user/view_services_screen/view_single_service.dart';

class ServiceGridItem extends StatelessWidget {
  const ServiceGridItem({
    Key? key,
    required this.title,
    required this.icon,
  }) : super(key: key);
  final String title;
  final String icon;

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
          color: const Color.fromRGBO(249, 185, 36, 1),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Colors.grey,
              blurRadius: 15.0, // soften the shadow
              spreadRadius: 3.0, //extend the shadow
              offset: Offset(
                5.0, // Move to right 5  horizontally
                5.0, // Move to bottom 5 Vertically
              ),
            )
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Column(
            children: [
              _icon(title, icon, sHeight * 0.10, sWidth * 0.10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget _icon(String type, String path, double h, double w) {
  switch (type) {
    case 'Oil':
      return Image.asset(path, color: Colors.black, height: h, width: w);
    /*return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/images/serviceMotorOil.png'),
      );*/
    case 'Tires':
      return Image.asset(path, color: Colors.black, height: h, width: w);
    case 'Brakes':
      return Image.asset(path, color: Colors.black, height: h, width: w);
    case 'Other':
      return Image.asset(path, color: Colors.black, height: h, width: w);
    default:
      return Image.asset(path, color: Colors.black, height: h, width: w);
  }
}
