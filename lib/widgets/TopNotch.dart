import 'package:flutter/material.dart';

class TopNotch extends StatelessWidget {
  const TopNotch({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sHeight = size.height;
    return Container(
      height: sHeight * 0.12,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
        color: Color.fromRGBO(
          88,
          101,
          242,
          1,
        ),
      ),
    );
  }
}
