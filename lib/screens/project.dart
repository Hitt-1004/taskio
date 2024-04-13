import 'package:flutter/material.dart';

class projects extends StatefulWidget {
  const projects({super.key});

  @override
  State<projects> createState() => _projectsState();
}

class _projectsState extends State<projects> {
  int selIndex = 1;

  void onTapped(int index){
    if(index == 0) Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    if(index == 2) Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Projects'),),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF6146C6),
        onTap: onTapped,
        currentIndex: selIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.paste_outlined),
            label: 'Projects',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
