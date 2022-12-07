import 'package:flutter/material.dart';

import '../auth_screen/widgets/button.dart';
import '../../widgets/top_notch.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: Column(
        children: [
          const TopNotch(withBack: false),
          SizedBox(
            height: sHeight * 0.1,
          ),
          // The logo pic
          SizedBox(
            width: sWidth * 0.56,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset('assets/images/appLogo.jpg'),
            ),
          ),
          SizedBox(
            height: sHeight * 0.15,
          ),
          const Button(
            label: 'User',
            isWorkshop: false,
          ),
          SizedBox(
            height: sHeight * 0.05,
          ),
          const Button(
            label: 'Workshop',
            isWorkshop: true,
          ),
        ],
      ),
    );
  }
}
