import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/Post.dart';
import 'package:repairity/models/app_user.dart';
import 'package:repairity/widgets/button.dart';
import 'package:repairity/widgets/horizontal_divider.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../../models/comment.dart';
import '../../user/view_workshop_profile_screen/view_workshop_profile_screen.dart';
import 'components/view_single_post_handler.dart';
import 'widgets/add_comment_button.dart';

class ViewSinglePostScreen extends StatefulWidget {
  const ViewSinglePostScreen({super.key, required this.post});
  final Post post;

  @override
  State<ViewSinglePostScreen> createState() => _ViewSinglePostScreenState();
}

class _ViewSinglePostScreenState extends State<ViewSinglePostScreen> {
  late Future<AppUser> userFuture;
  late Future<List<Comment>> commentsFuture;
  @override
  void initState() {
    // TODO: implement initState
    userFuture = Provider.of<ViewSinglePostHandler>(context, listen: false)
        .getUser(widget.post.ownerId);
    commentsFuture = Provider.of<ViewSinglePostHandler>(context, listen: false)
        .getPostComments(widget.post.id);
    super.initState();
  }

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
            FutureBuilder(
              future: userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      SizedBox(
                        height: sHeight * 0.4,
                      ),
                      const CircularProgressIndicator(),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: sWidth * 0.04,
                          ),
                          Text(snapshot.data!.username),
                          const Spacer(),
                          SizedBox(
                              height: sHeight * 0.06,
                              width: sWidth * 0.4,
                              child: Button(label: 'Chat', function: () {}))
                        ],
                      ),
                      Container(
                          margin:
                              EdgeInsets.symmetric(vertical: sHeight * 0.01),
                          child: HorizontalDivider(
                              sWidth: sWidth, sHeight: sHeight)),
                      Text(widget.post.description),
                      ListView.separated(
                        separatorBuilder: (context, index) => Container(
                          height: sHeight * 0.009,
                        ),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.post.imgCount,
                        itemBuilder: (context, index) {
                          return FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image:
                                'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/posts-images/${widget.post.id}/$index.jpeg',
                            height: sHeight * 0.5,
                          );
                        },
                      ),
                      SizedBox(
                        height: sHeight * 0.03,
                      ),
                      HorizontalDivider(sWidth: sWidth, sHeight: sHeight),
                      Row(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: sWidth * 0.03),
                            child: const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Comments',
                                style: TextStyle(fontSize: 21),
                              ),
                            ),
                          ),
                          const Spacer(),
                          AddCommentButton(
                            post: widget.post,
                          )
                        ],
                      ),
                      HorizontalDivider(sWidth: sWidth, sHeight: sHeight)
                    ],
                  ),
                );
              },
            ),
            FutureBuilder(
                future: commentsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  final List<Comment> allComments = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) => Container(
                      margin: EdgeInsets.all(sHeight * 0.02),
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
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              ViewWorkshopProfileScreen(
                                                  workshop: allComments[index]
                                                      .workshop),
                                        ));
                                  },
                                  child: Text(
                                    allComments[index].workshop.username,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: sHeight * 0.01,
                            ),
                            Row(
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      const TextSpan(text: 'i can do this for'),
                                      TextSpan(
                                          text:
                                              ' ${allComments[index].price.toString()}',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 245, 110, 100))),
                                      const TextSpan(
                                          text: ' Riyals \nit will take '),
                                      TextSpan(
                                          text: allComments[index]
                                              .duration
                                              .toString(),
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 250, 114, 104))),
                                      const TextSpan(text: ' days'),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ViewWorkshopProfileScreen(
                                                    workshop: allComments[index]
                                                        .workshop),
                                          ));
                                    },
                                    child: const Text('Contact'))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                })
          ],
        ),
      ),
    );
  }
}
