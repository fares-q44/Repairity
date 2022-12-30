import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({
    Key? key,
    required this.username,
    required this.review,
    required this.rate,
  }) : super(key: key);

  final String username;
  final String review;
  final int rate;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Container(
        margin: EdgeInsets.only(bottom: sHeight * 0.02),
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
                  Text(
                    username,
                    style: const TextStyle(color: Colors.white),
                  ),
                  const Spacer(),
                  RatingBar.builder(
                    ignoreGestures: true,
                    itemSize: (sHeight + sWidth) * 0.015,
                    initialRating: rate.toDouble(),
                    direction: Axis.horizontal,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
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
              Text(
                review,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }
}
