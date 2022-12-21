import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:repairity/models/place.dart';
import 'package:repairity/screens/auth_screen/map_helpers/map_screen.dart';
import 'package:repairity/widgets/horizontal_divider.dart';
import 'package:repairity/widgets/top_notch.dart';

import '../../../models/workshop.dart';
import '../../auth_screen/map_helpers/location_helper.dart';
import '../view_services_screen/widgets/workshop_information_container.dart';

class ViewWorkshopProfileScreen extends StatelessWidget {
  const ViewWorkshopProfileScreen(
      {super.key, required this.workshop, required this.distance});
  final Workshop workshop;
  final double distance;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopNotch(withBack: true, withAdd: false),
            Padding(
              padding: EdgeInsets.all(sWidth * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/profile-pictures/${workshop.id}',
                          height: sHeight * 0.2,
                        ),
                      ),
                      WorkshopInformationContainer(
                        workshop: workshop,
                        distance: distance,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: sHeight * 0.03,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return MapScreen(
                            initialLocation: PlaceLocation(
                              latitude: workshop.lat,
                              longitude: workshop.lon,
                            ),
                            isSelecting: false,
                          );
                        },
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black,
                        ),
                      ),
                      child: Image.network(
                        fit: BoxFit.cover,
                        LocationHelper.generateLocationPreviewImage(
                            latitude: workshop.lat, longtitude: workshop.lon),
                        width: double.infinity,
                        height: sHeight * 0.3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sHeight * 0.017,
                  ),
                  HorizontalDivider(sWidth: sWidth, sHeight: sHeight),
                  const Text(
                    'Reviews',
                    style: TextStyle(fontSize: 22),
                  ),
                  HorizontalDivider(sWidth: sWidth, sHeight: sHeight),
                  SizedBox(
                    height: sHeight * 0.01,
                  ),
                  Column(
                    children: [
                      Container(
                        width: double.infinity,
                        height: sHeight * 0.13,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).primaryColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Text(
                                    'username',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  const Spacer(),
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
                                ],
                              ),
                              SizedBox(
                                height: sHeight * 0.01,
                              ),
                              const Text(
                                'Lorem Ipsum 00s, when an unknownr took a galley of type and scrambled it to make a type specimen book. It has survived ',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
