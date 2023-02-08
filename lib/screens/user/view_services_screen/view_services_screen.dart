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
        Expanded(
          child: GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            crossAxisCount: 2,
            children: const <Widget>[
              ServiceGridItem(
                icon: Icons.tire_repair,
                title: 'Tires',
              ),
              ServiceGridItem(
                icon: Icons.oil_barrel,
                title: 'Oil',
              ),
              ServiceGridItem(
                icon: Icons.car_crash,
                title: 'Brakes',
              ),
              ServiceGridItem(
                icon: Icons.car_rental,
                title: 'Anything',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
