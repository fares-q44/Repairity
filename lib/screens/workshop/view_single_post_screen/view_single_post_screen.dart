import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:repairity/models/Post.dart';
import 'package:repairity/widgets/button.dart';
import 'package:repairity/widgets/horizontal_divider.dart';
import 'package:repairity/widgets/top_notch.dart';
import 'package:transparent_image/transparent_image.dart';

import 'components/view_single_post_handler.dart';

class ViewSinglePostScreen extends StatefulWidget {
  const ViewSinglePostScreen({super.key, required this.post});
  final Post post;

  @override
  State<ViewSinglePostScreen> createState() => _ViewSinglePostScreenState();
}

class _ViewSinglePostScreenState extends State<ViewSinglePostScreen> {
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
              future: Provider.of<ViewSinglePostHandler>(context, listen: false)
                  .getUser(widget.post.ownerId),
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
                          SizedBox(
                            height: sHeight * 0.04,
                            width: sWidth * 0.2,
                            child: Button(
                              label: 'Add comment',
                              function: () {},
                            ),
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
              builder: (context, snapshot) => ListView.builder(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 1,
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
                          children: const [
                            Text(
                              'username',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: sHeight * 0.01,
                        ),
                        const Text(
                          'review',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
