import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/workshop.dart';
import 'package:repairity/screens/user/view_workshops_screen/components/view_workshops_handler.dart';
import 'package:repairity/widgets/top_notch.dart';

class ViewWorkshopScreen extends StatelessWidget {
  const ViewWorkshopScreen({super.key});

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Column(
      children: [
        TopNotch(withBack: false, withAdd: false),
        FutureBuilder(
          future: Provider.of<ViewWorkshopHandler>(context, listen: false)
              .fetchAndSetWorkshops(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  SizedBox(
                    height: sHeight * 0.35,
                  ),
                  const CircularProgressIndicator(),
                ],
              );
            } else {
              final List<Workshop> fetchedWorkshops = snapshot.data!;
              final List<double> distanceList = [];
              return Expanded(
                child: ListView.builder(
                  itemCount: fetchedWorkshops.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: calculateDistance(fetchedWorkshops[index].lat,
                          fetchedWorkshops[index].lon),
                      builder: (context, snapshot) => Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(fetchedWorkshops[index].username),
                                  Image.file(
                                    fetchedWorkshops[index].profilePic,
                                    height: sHeight * 0.2,
                                    width: sWidth * 0.2,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            Column(
                              children: [
                                RatingBar.builder(
                                  ignoreGestures: true,
                                  itemSize: (sHeight + sWidth) * 0.015,
                                  initialRating: 3,
                                  direction: Axis.horizontal,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                                SizedBox(
                                  height: sHeight * 0.03,
                                ),
                                Row(
                                  children: [
                                    const Icon(Icons.location_on),
                                    Text(
                                      snapshot.connectionState ==
                                              ConnectionState.waiting
                                          ? 'Calculating distance...'
                                          : '${snapshot.data!.toStringAsFixed(2)} KM',
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        )
      ],
    );
  }
}
