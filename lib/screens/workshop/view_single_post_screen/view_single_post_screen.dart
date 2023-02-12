import 'package:fan_carousel_image_slider/fan_carousel_image_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/Post.dart';
import 'package:repairity/models/app_user.dart';
import 'package:repairity/screens/user/view_workshop_profile_screen/widgets/WidgetHolder.dart';
import 'package:repairity/widgets/button.dart';
import 'package:repairity/widgets/horizontal_divider.dart';

import '../../../models/chat.dart';
import '../../../models/comment.dart';
import '../../chat_screen/chatting_screen.dart';
import '../../chat_screen/components/chat_handler.dart';
import 'components/view_single_post_handler.dart';
import 'widgets/add_comment_button.dart';
import 'widgets/single_chat_item.dart';

class ViewSinglePostScreen extends StatefulWidget {
  const ViewSinglePostScreen(
      {super.key, required this.post, required this.isUser});
  final Post post;
  final bool isUser;
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(widget.post.title),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder(
              future: userFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Column(
                    children: [
                      SizedBox(
                        height: sHeight * 0.4,
                      ),
                      const Center(child: CircularProgressIndicator()),
                    ],
                  );
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      WidgetHolder(
                        Child: Row(
                          children: [
                            SizedBox(
                              width: sWidth * 0.04,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data!.username),
                                SizedBox(
                                  height: sHeight * 0.01,
                                ),
                                Text(DateTime.now()
                                            .difference(widget.post.date)
                                            .inDays !=
                                        0
                                    ? '${DateTime.now().difference(widget.post.date).inDays.toString()} Days ago'
                                    : DateTime.now()
                                                .difference(widget.post.date)
                                                .inHours !=
                                            0
                                        ? '${DateTime.now().difference(widget.post.date).inHours.toString()} Hours ago'
                                        : '${DateTime.now().difference(widget.post.date).inMinutes.toString()} Minutes ago'),
                              ],
                            ),
                            const Spacer(),
                            SizedBox(
                              height: sHeight * 0.06,
                              width: sWidth * 0.4,
                              child: widget.isUser
                                  ? Container()
                                  : Button(
                                      label: 'Chat',
                                      function: () async {
                                        ///initiate the chat or just open it if it exits
                                        final Chat selectedChat = await Provider
                                                .of<ChatHandler>(context,
                                                    listen: false)
                                            .initiateChat(widget.post.ownerId);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => ChatPage(
                                                    selectedChat: selectedChat,
                                                  )),
                                        );
                                      },
                                    ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      WidgetHolder(
                        Child: Column(
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(widget.post.description)),
                            ListView.separated(
                              separatorBuilder: (context, index) => Container(
                                height: sHeight * 0.009,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                List<String> sampleImages = [];
                                for (var i = 0; i < widget.post.imgCount; i++) {
                                  sampleImages.add(
                                      'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/posts-images/${widget.post.id}/$i.jpeg');
                                }
                                return FanCarouselImageSlider(
                                  initalPageIndex: 0,
                                  imagesLink: sampleImages,
                                  isAssets: false,
                                  autoPlay: false,
                                  isClickable: true,
                                  userCanDrag: true,
                                  imageRadius: 10,
                                  turns: 1000,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      WidgetHolder(
                          Child: Row(
                        children: [
                          const Icon(
                            Icons.warning,
                            color: Colors.orange,
                          ),
                          SizedBox(
                            width: sWidth * 0.02,
                          ),
                          const Text(
                              'The displayed prices are just estimated prices, Prices may\nchange after further inspection')
                        ],
                      )),
                      SizedBox(
                        height: sHeight * 0.01,
                      ),
                      WidgetHolder(
                        Child: Column(
                          children: [
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
                                widget.isUser
                                    ? Container()
                                    : AddCommentButton(
                                        post: widget.post,
                                      )
                              ],
                            ),
                            HorizontalDivider(sWidth: sWidth, sHeight: sHeight),
                            FutureBuilder(
                                future: commentsFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator();
                                  }
                                  final List<Comment> allComments =
                                      snapshot.data!;
                                  if (allComments.isEmpty) {
                                    return const Text('There is no comments');
                                  } else {
                                    return ListView.builder(
                                      padding: EdgeInsets.zero,
                                      scrollDirection: Axis.vertical,
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: snapshot.data!.length,
                                      itemBuilder: (context, index) =>
                                          SingleCommentItem(
                                        comment: allComments[index],
                                        isUser: widget.isUser,
                                      ),
                                    );
                                  }
                                })
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
