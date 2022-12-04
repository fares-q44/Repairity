import 'package:flutter/material.dart';
import 'package:repairity/screens/auth_screen/AuthScreen.dart';

class Button extends StatelessWidget {
  const Button({
    Key? key,
    required this.label,
    required this.isWorkshop,
  }) : super(key: key);

  final String label;
  final bool isWorkshop;
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
            builder: (context) => AuthScreen(isWorkshop: isWorkshop),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.black,
        ),
        height: sHeight * 0.08,
        width: sWidth * 0.8,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
    );
  }
}
