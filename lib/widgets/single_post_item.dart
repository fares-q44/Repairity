import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/bottom_nav_bar_screen/bottom_nav_bar.dart';
import 'package:repairity/screens/user/user_posts_screen/components/user_posts.dart';
import 'package:repairity/screens/workshop/view_single_post_screen/view_single_post_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/Post.dart';

class SinglePostItem extends StatefulWidget {
  const SinglePostItem({
    Key? key,
    required this.allPosts,
    required this.isUser,
  }) : super(key: key);
  final List<Post> allPosts;
  final bool isUser;

  @override
  State<SinglePostItem> createState() => _SinglePostItemState();
}

class _SinglePostItemState extends State<SinglePostItem> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Expanded(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewSinglePostScreen(
                    post: widget.allPosts[index], isUser: widget.isUser),
              )),
          child: Dismissible(
            direction: widget.isUser
                ? DismissDirection.endToStart
                : DismissDirection.none,
            key: UniqueKey(),
            background: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3),
              child: Container(
                color: Colors.red,
                child: const Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.delete),
                  ),
                ),
              ),
            ),
            confirmDismiss: (DismissDirection direction) async {
              return await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("Confirm"),
                    content: const Text(
                        "Are you sure you wish to delete this item?"),
                    actions: <Widget>[
                      ElevatedButton(
                          onPressed: () async {
                            String tempid = widget.allPosts[index].id;
                            setState(() {
                              widget.allPosts.remove(widget.allPosts[index]);
                            });
                            await Provider.of<UserPosts>(context, listen: false)
                                .deletePost(tempid);
                            Navigator.of(context).pop();
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomNavBar(),
                                ));
                          },
                          child: const Text("DELETE")),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("CANCEL"),
                      ),
                    ],
                  );
                },
              );
            },
            child: SizedBox(
              height: sHeight * 0.19,
              child: Card(
                color: const Color.fromARGB(255, 218, 218, 218),
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.allPosts[index].title,
                            style: const TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: sHeight * 0.02,
                          ),
                          Text(
                            DateTime.now()
                                        .difference(widget.allPosts[index].date)
                                        .inDays !=
                                    0
                                ? '${DateTime.now().difference(widget.allPosts[index].date).inDays.toString()} Days ago'
                                : DateTime.now()
                                            .difference(
                                                widget.allPosts[index].date)
                                            .inHours !=
                                        0
                                    ? '${DateTime.now().difference(widget.allPosts[index].date).inHours.toString()} Hours ago'
                                    : '${DateTime.now().difference(widget.allPosts[index].date).inMinutes.toString()} Minutes ago',
                            style: const TextStyle(
                                color: Color.fromARGB(255, 129, 129, 129)),
                          )
                        ],
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image:
                              'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/posts-images/${widget.allPosts[index].id}/0.jpeg',
                          height: sHeight * 0.15,
                          width: sWidth * 0.3,
                          fit: BoxFit.cover,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        itemCount: widget.allPosts.length,
      ),
    );
  }
}
