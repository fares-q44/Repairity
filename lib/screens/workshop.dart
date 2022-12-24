import 'package:flutter/material.dart';
import 'package:repairity/screens/chat_screen/chat_screen.dart';
import 'package:repairity/screens/service/main.dart';

class ScreenWorkshop extends StatefulWidget {
  const ScreenWorkshop({super.key});

  @override
  State<ScreenWorkshop> createState() => _ScreenWorkshopState();
}

class _ScreenWorkshopState extends State<ScreenWorkshop> {
  int pageIndex = 0;

  final List pages = const [
    ScreenServices(),
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
      body: pages[pageIndex],
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
            icon: Icon(Icons.handyman),
            label: 'Services',
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
