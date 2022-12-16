import 'package:flutter/material.dart';

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({
    Key? key,
    required this.sWidth,
    required this.sHeight,
  }) : super(key: key);

  final double sWidth;
  final double sHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: sWidth * 0.9,
      height: sHeight * 0.001,
      decoration: const BoxDecoration(color: Colors.black),
      margin: EdgeInsets.symmetric(vertical: sHeight * 0.01),
    );
  }
}
