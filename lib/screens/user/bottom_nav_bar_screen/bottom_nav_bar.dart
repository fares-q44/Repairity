import 'package:flutter/material.dart';
import 'package:repairity/screens/chat_screen/chat_screen.dart';
import 'package:repairity/screens/user/user_posts_screen/user_posts_screen.dart';
import 'package:repairity/screens/user/view_services_screen/view_services_screen.dart';
import 'package:repairity/screens/user/view_workshops_screen/view_workshops_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int pageIndex = 0;

  final List<Widget> pages = const [
    UserPostsScreen(),
    ViewServicesScreen(),
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
    Size size = MediaQuery.of(context).size;
    double sWidth = size.width;
    double sHeight = size.height;
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
        unselectedLabelStyle: const TextStyle(fontSize: 16),
        selectedLabelStyle: const TextStyle(fontSize: 16),
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/XMLID_23_posts_nav.png',
              height: sHeight * 0.03,
              color: pageIndex == 0 ? Colors.white : Colors.black,
            ),
            label: 'Posts',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/screw.png',
              height: sHeight * 0.03,
              color: pageIndex == 1 ? Colors.white : Colors.black,
            ),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/5976113 1workshops_nav.png',
              height: sHeight * 0.03,
              color: pageIndex == 2 ? Colors.white : Colors.black,
            ),
            label: 'Workshops',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/3269407 1chat_nav.png',
              height: sHeight * 0.03,
              color: pageIndex == 3 ? Colors.white : Colors.black,
            ),
            label: 'Chat',
          ),
        ],
      ),
    );
  }
}
