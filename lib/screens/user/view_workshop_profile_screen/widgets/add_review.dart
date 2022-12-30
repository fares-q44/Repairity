import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../../widgets/button.dart';

class AddReview extends StatefulWidget {
  const AddReview({
    Key? key,
    required this.myController,
    required this.submitReview,
  }) : super(key: key);

  final TextEditingController myController;
  final Function submitReview;

  @override
  State<AddReview> createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int rate = 0;
  bool isSubmitting = false;
  void submitReviewFunc() async {
    setState(() {
      isSubmitting = true;
    });
    await widget.submitReview(rate);
    setState(() {
      isSubmitting = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Column(
      children: [
        SizedBox(
          height: sHeight * 0.05,
        ),
        RatingBar.builder(
          allowHalfRating: false,
          ignoreGestures: false,
          itemSize: (sHeight + sWidth) * 0.03,
          initialRating: 0,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: const EdgeInsets.symmetric(
            horizontal: 4.0,
          ),
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            rate = rating.toInt();
          },
        ),
        Container(
          margin: EdgeInsets.symmetric(
              vertical: sHeight * 0.03, horizontal: sHeight * 0.02),
          height: sHeight * 0.2,
          child: TextField(
            controller: widget.myController,
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0, color: Colors.red),
              ),
              hintText: 'Enter your review here',
              labelText: 'Review',
              labelStyle: TextStyle(fontSize: 20),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
              ),
            ),
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            minLines: null,
            maxLines: null,
            expands: true,
          ),
        ),
        isSubmitting
            ? const CircularProgressIndicator()
            : Button(label: 'Rate', function: submitReviewFunc),
      ],
    );
  }
}
