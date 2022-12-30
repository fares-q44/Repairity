import 'package:flutter/material.dart';
import 'package:repairity/screens/chat_screen/chat_screen.dart';
import 'package:repairity/screens/service/main.dart';
import 'package:repairity/screens/workshop/view_posts_screen/view_posts_screen.dart';

import '../../user/view_workshops_screen/view_workshops_screen.dart';

class WorkshopNavBar extends StatefulWidget {
  const WorkshopNavBar({super.key});

  @override
  State<WorkshopNavBar> createState() => _WorkshopNavBarState();
}

class _WorkshopNavBarState extends State<WorkshopNavBar> {
  int pageIndex = 0;

  final List<Widget> pages = const [
    ViewPostsScreen(),
    ScreenServices(),
    ViewWorkshopScreen(),
    ChatScreen(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IndexedStack(
              index: pageIndex,
              children: pages,
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped,
        currentIndex: pageIndex,
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
            icon: Icon(Icons.fire_truck),
            label: 'Workshops',
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
