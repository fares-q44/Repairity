import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../models/workshop.dart';
import '../../view_workshop_profile_screen/view_workshop_profile_screen.dart';

class SingleWorkshopItem extends StatelessWidget {
  const SingleWorkshopItem({
    Key? key,
    required this.workshop,
    required this.snapshot,
  }) : super(key: key);

  final Workshop workshop;
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
                workshop: workshop,
                distance: snapshot.data == null ? 0.0 : snapshot.data!,
              ),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.only(bottom: sHeight * 0.015),
          color: const Color.fromARGB(255, 218, 218, 218),
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      workshop.username,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(
                      height: sHeight * 0.02,
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        child: FadeInImage.memoryNetwork(
                          image:
                              'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/profile-pictures/${workshop.id}',
                          placeholder: kTransparentImage,
                          height: sHeight * 0.13,
                          width: sWidth * 0.26,
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
                  SizedBox(
                    height: sHeight * 0.06,
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
                  SizedBox(
                    height: sHeight * 0.03,
                  ),
                  Row(
                    children: [
                      const Icon(Icons.location_on),
                      Text(
                        snapshot.connectionState == ConnectionState.waiting
                            ? 'Calc distance...'
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
