import 'package:flutter/material.dart';

import '../../../../models/comment.dart';
import '../../../user/view_workshop_profile_screen/view_workshop_profile_screen.dart';

class SingleCommentItem extends StatelessWidget {
  const SingleCommentItem({
    super.key,
    required this.comment,
    required this.isUser,
  });

  final Comment comment;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Container(
      margin: EdgeInsets.all(sHeight * 0.003),
      width: double.infinity,
      height: sHeight * 0.22,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromRGBO(42, 83, 189, 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isUser) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ViewWorkshopProfileScreen(
                                workshop: comment.workshop),
                          ));
                    }
                  },
                  child: Text(
                    comment.workshop.username,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const Spacer(),
                SizedBox(
                  width: sWidth * 0.3,
                  child: isUser
                      ? ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromRGBO(249, 185, 36, 1),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ViewWorkshopProfileScreen(
                                          workshop: comment.workshop),
                                ));
                          },
                          child: const Text(
                            'Contact',
                            style: TextStyle(color: Colors.black),
                          ))
                      : SizedBox(
                          width: sWidth * 0.3,
                          height: sHeight * 0.05,
                        ),
                ),
                SizedBox(
                  width: sWidth * 0.02,
                )
              ],
            ),
            SizedBox(
              height: sHeight * 0.01,
            ),
            Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(horizontal: sWidth * 0.027),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(56, 124, 255, 1),
                      borderRadius: BorderRadius.circular(15)),
                  height: sHeight * 0.12,
                  width: sWidth * 0.35,
                  child: Column(
                    children: [
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                      const Text(
                        'Price',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                      Text(
                        '${comment.price.toString()} SR',
                        style: const TextStyle(
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                      Image.asset(
                        'assets/icons/Vectormoney.png',
                        color: Colors.green,
                      ),
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.black,
                  height: sHeight * 0.1,
                  width: 1,
                  margin: EdgeInsets.symmetric(horizontal: sWidth * 0.02),
                ),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: sWidth * 0.025),
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(56, 124, 255, 1),
                      borderRadius: BorderRadius.circular(15)),
                  height: sHeight * 0.12,
                  width: sWidth * 0.35,
                  child: Column(
                    children: [
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                      const Text(
                        'Duration',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                      Text(
                        '${comment.duration.toString()} Days',
                        style: const TextStyle(
                          color: Color.fromRGBO(254, 131, 17, 1),
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                      Image.asset(
                        'assets/icons/chronometer-watch-3-second-svgrepo-com 1time.png',
                        color: const Color.fromRGBO(254, 131, 17, 1),
                      ),
                      SizedBox(
                        height: sHeight * 0.007,
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
