import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/Post.dart';
import 'package:repairity/screens/workshop/view_posts_screen/components/view_posts_handler.dart';
import 'package:repairity/widgets/single_post_item.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:shimmer/shimmer.dart';

class ViewPostsScreen extends StatefulWidget {
  const ViewPostsScreen({super.key});

  @override
  State<ViewPostsScreen> createState() => _ViewPostsScreenState();
}

class _ViewPostsScreenState extends State<ViewPostsScreen> {
  late Future<void> future;
  @override
  void initState() {
    // TODO: implement initState
    future = Provider.of<ViewPostsHandler>(context, listen: false)
        .fetchAndSetPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Post> allPosts =
        Provider.of<ViewPostsHandler>(context, listen: false).allPosts;
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            future = Provider.of<ViewPostsHandler>(context, listen: false)
                .fetchAndSetPosts();
          });
        },
        child: Column(
          children: [
            TopNotch(withBack: false, withAdd: false),
            FutureBuilder(
              future: future,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      enabled: true,
                      child: ListView.builder(
                        itemBuilder: (_, __) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 48.0,
                                height: 48.0,
                                color: Colors.white,
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 2.0),
                                    ),
                                    Container(
                                      width: 40.0,
                                      height: 8.0,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        itemCount: 9,
                      ),
                    ),
                  );
                }
                return SinglePostItem(
                  allPosts: allPosts.reversed.toList(),
                  isUser: false,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
