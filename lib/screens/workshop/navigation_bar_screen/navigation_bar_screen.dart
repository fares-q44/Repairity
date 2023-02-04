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
    ViewProfileScreen(),
    const ChatScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      widget.pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        unselectedLabelStyle: const TextStyle(color: Colors.white),
        selectedLabelStyle: const TextStyle(color: Colors.red),
        unselectedItemColor: Colors.white,
        selectedItemColor: const Color.fromARGB(255, 247, 147, 140),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.handyman),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
