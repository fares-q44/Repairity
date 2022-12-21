import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../models/workshop.dart';
import '../../view_workshop_profile_screen/view_workshop_profile_screen.dart';

class SingleWorkshopItem extends StatelessWidget {
  const SingleWorkshopItem({
    Key? key,
    required this.fetchedWorkshops,
    required this.snapshot,
  }) : super(key: key);

  final Workshop fetchedWorkshops;
  final AsyncSnapshot<double> snapshot;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return SizedBox(
      height: sHeight * 0.26,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ViewWorkshopProfileScreen(
                workshop: fetchedWorkshops,
                distance: snapshot.data == null ? 0.0 : snapshot.data!,
              ),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.only(bottom: sHeight * 0.02),
          color: const Color.fromARGB(255, 218, 218, 218),
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fetchedWorkshops.username),
                    SizedBox(
                      height: sHeight * 0.01,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: FadeInImage.memoryNetwork(
                          image:
                              'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/profile-pictures/${fetchedWorkshops.id}',
                          placeholder: kTransparentImage,
                          height: sHeight * 0.18,
                          width: sWidth * 0.3,
                          fit: BoxFit.cover,
                        ),
                      ),
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
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                        snapshot.connectionState == ConnectionState.waiting
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
      ),
    );
  }
}
