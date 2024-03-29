import 'package:flutter/material.dart';

class TopNotch extends StatelessWidget {
  TopNotch(
      {Key? key, required this.withBack, required this.withAdd, this.route})
      : super(key: key);
  final bool withBack;
  final bool withAdd;
  String? route;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sHeight = size.height;
    double sWidth = size.width;
    return Container(
        width: double.infinity,
        height: sHeight * 0.12,
        decoration: const BoxDecoration(
          // borderRadius: BorderRadius.only(
          // bottomRight: Radius.circular(20),
          // bottomLeft: Radius.circular(20),
          // ),
          color: Color.fromRGBO(
            56,
            124,
            255,
            1,
          ),
        ),
        child: Row(
          children: [
            withBack
                ? Container(
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
                  )
                : Container(),
            withAdd
                ? Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, route!);
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  )
                : Container(),
          ],
        ));
  }
}
