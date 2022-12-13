import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/user/user_posts/components/user_posts.dart';
import 'package:repairity/widgets/top_notch.dart';

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
          SizedBox(
            height: sHeight * 0.35,
          ),
          FutureBuilder(
            future:
                Provider.of<UserPosts>(context, listen: false).getOwnPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                if (snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => Card(
                        child: Column(
                          children: [
                            Text(snapshot.data![index].title),
                            Text(snapshot.data![index].contact),
                            Text(snapshot.data![index].description),
                          ],
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
