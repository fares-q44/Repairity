import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/screens/workshop/view_posts_screen/components/view_posts_handler.dart';
import 'package:repairity/widgets/single_post_item.dart';
import 'package:repairity/widgets/top_notch.dart';

class ViewPostsScreen extends StatelessWidget {
  const ViewPostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          TopNotch(withBack: false, withAdd: false),
          FutureBuilder(
            future: Provider.of<ViewPostsHandler>(context, listen: false)
                .fetchAndSetPosts(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              }
              return SinglePostItem(snapshot: snapshot);
            },
          )
        ],
      ),
    );
  }
}
