import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/place.dart';
import 'package:repairity/screens/auth_screen/map_helpers/map_screen.dart';
import 'package:repairity/widgets/button.dart';
import 'package:repairity/widgets/horizontal_divider.dart';
import 'package:repairity/widgets/top_notch.dart';

import '../../../models/workshop.dart';
import '../../auth_screen/map_helpers/location_helper.dart';
import 'widgets/workshop_information_container.dart';
import 'components/view_workshop_handler.dart';
import 'widgets/add_review.dart';
import 'widgets/all_reviews.dart';

class ViewWorkshopProfileScreen extends StatelessWidget {
  ViewWorkshopProfileScreen(
      {super.key, required this.workshop, this.distance = -1});
  final Workshop workshop;
  double distance;
  final myController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    void submitReview(int rate) async {
      await Provider.of<ViewSingleWorkshopHandler>(context, listen: false)
          .submitReview(
        rate,
        myController.text,
        workshop.id,
      );
      Navigator.pop(context);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ViewWorkshopProfileScreen(
                workshop: workshop, distance: distance),
          ));
    }

    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MapScreen(
                              initialLocation: PlaceLocation(
                                latitude: workshop.lat,
                                longitude: workshop.lon,
                              ),
                              isSelecting: false,
                            );
                          },
                        ),
                      );
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
                          latitude: workshop.lat,
                          longtitude: workshop.lon,
                        ),
                        width: double.infinity,
                        height: sHeight * 0.3,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: sHeight * 0.017,
                  ),
                  Container(
                      margin: EdgeInsets.only(bottom: sHeight * 0.01),
                      child:
                          HorizontalDivider(sWidth: sWidth, sHeight: sHeight)),
                  Align(
                    alignment: Alignment.center,
                    child: Button(
                      label: 'Rate this workshop',
                      function: () {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: (BuildContext context) {
                            return AddReview(
                              myController: myController,
                              submitReview: submitReview,
                            );
                          },
                        );
                      },
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
                  AllReviews(
                    workshopID: workshop.id,
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
