import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/user_posts_screen/components/user_posts.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:transparent_image/transparent_image.dart';

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
                return Column(
                  children: [
                    SizedBox(
                      height: sHeight * 0.4,
                    ),
                    const CircularProgressIndicator()
                  ],
                );
              } else {
                if (snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) => SizedBox(
                        height: sHeight * 0.19,
                        child: Card(
                          color: const Color.fromARGB(255, 218, 218, 218),
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const Spacer(),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image:
                                      'https://atpuopxuvfwzdzfzxawq.supabase.co/storage/v1/object/public/posts-images/${snapshot.data![index].id}/0.jpeg',
                                  height: sHeight * 0.15,
                                  width: sWidth * 0.3,
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      itemCount: snapshot.data!.length,
                    ),
                  );
                }
                return Column(
                  children: [
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
                            color: Colors.red,
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
