import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../models/workshop.dart';

class WorkshopInformationContainer extends StatelessWidget {
  WorkshopInformationContainer({
    Key? key,
    required this.workshop,
    required this.distance,
  }) : super(key: key);

  final Workshop workshop;
  double distance;

  @override
  Widget build(BuildContext context) {
    Future<double> calculateDistance(lat2, lon2) async {
      try {
        final currentLocation = await Geolocator.getCurrentPosition();
        final lat1 = currentLocation.latitude;
        final lon1 = currentLocation.longitude;
        return Geolocator.distanceBetween(lat1, lon1, lat2, lon2) / 1000;
      } catch (e) {
        print(e);
        return 0;
      }
    }

    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Container(
      margin: EdgeInsets.only(left: sWidth * 0.03),
      height: sHeight * 0.2,
      width: sWidth * 0.45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: sHeight * 0.02,
            ),
            Text(
              workshop.username,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                vertical: sHeight * 0.005,
              ),
              child: Container(
                width: sWidth * 0.4,
                height: sHeight * 0.001,
                decoration: const BoxDecoration(color: Colors.black),
                margin: EdgeInsets.symmetric(vertical: sHeight * 0.01),
              ),
            ),
            RatingBar.builder(
              ignoreGestures: true,
              itemSize: (sHeight + sWidth) * 0.015,
              initialRating: workshop.rating.toDouble(),
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
              child: Container(
                width: sWidth * 0.4,
                height: sHeight * 0.001,
                decoration: const BoxDecoration(color: Colors.black),
                margin: EdgeInsets.symmetric(vertical: sHeight * 0.01),
              ),
            ),
            Row(
              children: [
                const Icon(Icons.location_on),
                distance == -1
                    ? FutureBuilder(
                        future: calculateDistance(workshop.lat, workshop.lon),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Text('Loading distance');
                          } else {
                            distance = snapshot.data!;
                            return Text(distance.toStringAsFixed(2));
                          }
                        },
                      )
                    : Text(distance.toStringAsFixed(2)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
