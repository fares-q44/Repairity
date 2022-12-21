import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../models/workshop.dart';
import '../../../../widgets/horizontal_divider.dart';

class WorkshopInformationContainer extends StatelessWidget {
  const WorkshopInformationContainer({
    Key? key,
    required this.workshop,
    required this.distance,
  }) : super(key: key);

  final Workshop workshop;
  final double distance;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Container(
      margin: EdgeInsets.only(left: sWidth * 0.03),
      height: sHeight * 0.2,
      width: sWidth * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 223, 223, 223),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(workshop.username),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: sHeight * 0.005,
              ),
              child: HorizontalDivider(sWidth: sWidth, sHeight: sHeight),
            ),
            RatingBar.builder(
              ignoreGestures: true,
              itemSize: (sHeight + sWidth) * 0.015,
              initialRating: 3,
              direction: Axis.horizontal,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {},
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: sHeight * 0.005,
              ),
              child: HorizontalDivider(
                sWidth: sWidth,
                sHeight: sHeight,
              ),
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                Text(distance.toStringAsFixed(2)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
