import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/user_posts_screen/components/user_posts.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:shimmer/shimmer.dart';

import '../../../widgets/single_post_item.dart';

class UserPostsScreen extends StatefulWidget {
  const UserPostsScreen({super.key});

  @override
  State<UserPostsScreen> createState() => _UserPostsScreenState();
}

class _UserPostsScreenState extends State<UserPostsScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: Column(
        children: [
          TopNotch(
            withBack: false,
            withAdd: true,
            route: '/add_post',
          ),
          FutureBuilder(
            future:
                Provider.of<UserPosts>(context, listen: false).getOwnPosts(),
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
              } else {
                if (snapshot.data!.isNotEmpty) {
                  return SinglePostItem(
                    allPosts: snapshot.data!.reversed.toList(),
                    isUser: true,
                  );
                }
                return Column(
                  children: [
                    SizedBox(
                      height: sHeight * 0.37,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/add_post');
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: sHeight * 0.02),
                        width: sWidth * 0.18,
                        height: sHeight * 0.09,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: Theme.of(context).primaryColor,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Center(
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                    const Center(
                      child: Text(
                        'No Posts Yet',
                        style: TextStyle(fontSize: 20),
                      ),
                    )
                  ],
                );
              }
            },
          )
        ],
      ),
    );
  }
}
