import 'package:flutter/material.dart';

class TopNotch extends StatelessWidget {
  const TopNotch({
    Key? key,
    required this.withBack,
  }) : super(key: key);
  final bool withBack;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sHeight = size.height;
    return Container(
      width: double.infinity,
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
      child: withBack
          ? Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          : Container(),
    );
  }
}
