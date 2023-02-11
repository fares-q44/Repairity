import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../../models/service2.dart';
import '../../view_workshop_profile_screen/view_workshop_profile_screen.dart';

class SingleServiceItem extends StatelessWidget {
  const SingleServiceItem({
    Key? key,
    required this.service,
    required this.snapshot,
  }) : super(key: key);

  final Service2 service;
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
                workshop: service.workshop,
              ),
            ),
          );
        },
        child: Card(
          margin: EdgeInsets.symmetric(
            horizontal: sWidth * 0.01,
            vertical: sHeight * 0.0015,
          ),
          elevation: 5,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.workshop.username,
                      style: const TextStyle(
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
                              'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/profile-pictures/${service.workshop.id}',
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
              Text(
                "Name: ${service.name}\n\nPrice: ${service.price} SR\n\nLabor: ${service.costLabor} SR",
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              Column(
                children: [
                  SizedBox(
                    height: sHeight * 0.06,
                  ),
                  RatingBar.builder(
                    glow: true,
                    ignoreGestures: true,
                    itemSize: (sHeight + sWidth) * 0.01,
                    initialRating: service.workshop.rating.toDouble(),
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
