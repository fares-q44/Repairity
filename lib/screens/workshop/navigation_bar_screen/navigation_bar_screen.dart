import 'package:flutter/material.dart';
import 'package:repairity/screens/chat_screen/chat_screen.dart';
import 'package:repairity/screens/service/main.dart';
import 'package:repairity/screens/workshop/view_posts_screen/view_posts_screen.dart';
import 'package:repairity/screens/workshop/view_profile_screen/view_profile_screen.dart';

class WorkshopNavBar extends StatefulWidget {
  WorkshopNavBar({super.key, this.pageIndex = 0});
  int pageIndex = 0;
  @override
  State<WorkshopNavBar> createState() => _WorkshopNavBarState();
}

class _WorkshopNavBarState extends State<WorkshopNavBar> {
  final List<Widget> pages = [
    const ViewPostsScreen(),
    const ScreenServices(),
    const ViewProfileScreen(),
    const ChatScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      widget.pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: widget.pageIndex,
              children: pages,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: widget.pageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.fixed,
        unselectedLabelStyle:
            const TextStyle(fontSize: 16, color: Colors.black),
        selectedLabelStyle: const TextStyle(fontSize: 16, color: Colors.white),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/Vectoruserposts.png',
              height: sHeight * 0.03,
              color: widget.pageIndex == 0 ? Colors.white : Colors.black,
            ),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/screw.png',
              height: sHeight * 0.03,
              color: widget.pageIndex == 1 ? Colors.white : Colors.black,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/5976113 1workshops_nav.png',
              height: sHeight * 0.03,
              color: widget.pageIndex == 2 ? Colors.white : Colors.black,
            ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/3269407 1chat_nav.png',
              height: sHeight * 0.03,
              color: widget.pageIndex == 3 ? Colors.white : Colors.black,
            ),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
