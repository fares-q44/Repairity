import 'package:counter/counter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/Post.dart';
import 'package:repairity/screens/workshop/view_single_post_screen/view_single_post_screen.dart';
import 'package:repairity/widgets/button.dart';

import '../components/view_single_post_handler.dart';

class AddCommentButton extends StatefulWidget {
  const AddCommentButton({
    Key? key,
    required this.post,
  }) : super(key: key);
  final Post post;

  @override
  State<AddCommentButton> createState() => _AddCommentButtonState();
}

class _AddCommentButtonState extends State<AddCommentButton> {
  String price = '';

  int duration = 0;

  TextEditingController priceController = TextEditingController();

  final priceKey = GlobalKey<FormFieldState>();
  bool isLoading = false;

  void addComment() {
    setState(() {
      isLoading = true;
    });

    if (priceKey.currentState!.validate()) {
      Provider.of<ViewSinglePostHandler>(context, listen: false)
          .addComment(widget.post.id, int.parse(price), duration);
    }
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return GestureDetector(
      onTap: () {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(
              builder: (context, setState) => Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Comment',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    SizedBox(
                      height: sHeight * 0.03,
                    ),
                    Container(
                        margin: const EdgeInsets.only(top: 10),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 5,
                        ),
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(29),
                        ),
                        child: TextFormField(
                          key: priceKey,
                          controller: priceController,
                          validator: (value) {
                            if (value!.isEmpty ||
                                double.tryParse(value) == null) {
                              return 'Please provide a valid price';
                            }
                            return null;
                          },
                          onSaved: (enteredPrice) => price = enteredPrice!,
                          decoration: const InputDecoration(
                              suffixIcon: Icon(Icons.money),
                              errorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              ),
                              hintText: 'Enter your price here',
                              labelText: 'Price',
                              labelStyle: TextStyle(fontSize: 20),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.black),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1.0, color: Colors.red),
                              )),
                        )),
                    SizedBox(
                      height: sHeight * 0.03,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: sWidth * 0.05,
                        ),
                        const Text('Duration in days: '),
                        Counter(
                          min: 0,
                          max: double.infinity,
                          step: 1,
                          onValueChanged: (value) => duration = value.toInt(),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: sHeight * 0.06,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: isLoading
                          ? const CircularProgressIndicator()
                          : Button(
                              label: 'Add comment',
                              function: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                if (priceKey.currentState!.validate()) {
                                  await Provider.of<ViewSinglePostHandler>(
                                          context,
                                          listen: false)
                                      .addComment(
                                          widget.post.id,
                                          int.parse(priceController.text),
                                          duration);
                                  Navigator.of(context).pop();
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ViewSinglePostScreen(
                                                  post: widget.post)));
                                }
                                setState(() {
                                  isLoading = false;
                                });
                              },
                            ),
                    )
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(13),
          color: Colors.black,
        ),
        height: sHeight * 0.07,
        width: sWidth * 0.5,
        child: const Center(
          child: Text(
            'Add comment',
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
