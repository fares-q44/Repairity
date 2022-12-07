import 'package:flutter/material.dart';
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
          const TopNotch(withBack: false),
          SizedBox(
            height: sHeight * 0.35,
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
      ),
    );
  }
}
