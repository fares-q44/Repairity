import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repairity/screens/auth_screen/auth_screen.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
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
        decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 201, 200, 200),
            boxShadow: [
              BoxShadow(
                  color: Colors.black54,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75))
            ]),
        height: sHeight * 0.25,
        width: sWidth * 0.8,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
                label == 'User'
                    ? 'assets/icons/User Login.svg'
                    : 'assets/icons/Workshop Login.svg',
                height: sHeight * 0.15),
            Text(
              label,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
