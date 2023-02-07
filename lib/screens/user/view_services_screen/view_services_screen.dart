import 'package:flutter/material.dart';
import 'package:repairity/widgets/top_notch.dart';

import 'widgets/service_grid_item.dart';

class ViewServicesScreen extends StatelessWidget {
  const ViewServicesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;

    return Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
        const SizedBox(
          height: 12,
        ),
        CircleAvatar(
          radius: 100,
          backgroundColor: const Color.fromRGBO(56, 124, 255, 1),
          child: Image.asset(
            'assets/images/Group1746.png',
            width: sWidth * 0.6,
            height: sHeight * 0.6,
          ),
        ),
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: const <Widget>[
              ServiceGridItem(
                icon: 'assets/icons/Tires.png',
                title: 'Tires',
              ),
              ServiceGridItem(
                icon: 'assets/icons/Oil.png',
                title: 'Oil',
              ),
              ServiceGridItem(
                icon: 'assets/icons/Brakes.png',
                title: 'Brakes',
              ),
              ServiceGridItem(
                icon: 'assets/icons/Other.png',
                title: 'Other',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
