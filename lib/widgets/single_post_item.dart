import 'package:flutter/material.dart';
import 'package:repairity/screens/workshop/view_single_post_screen/view_single_post_screen.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/Post.dart';

class SinglePostItem extends StatelessWidget {
  const SinglePostItem({
    Key? key,
    required this.snapshot,
  }) : super(key: key);
  final AsyncSnapshot<List<Post>> snapshot;
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
                builder: (context) =>
                    ViewSinglePostScreen(post: snapshot.data![index]),
              )),
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
        ),
        itemCount: snapshot.data!.length,
      ),
    );
  }
}
