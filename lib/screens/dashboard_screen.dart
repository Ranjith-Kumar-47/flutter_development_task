import 'package:flutter/material.dart';
import 'package:flutter_development_task/screens/account_screen.dart';
import 'package:flutter_development_task/screens/explore_screen.dart';
import 'package:flutter_development_task/screens/home_screen.dart';
import 'package:flutter_development_task/screens/meetup_screen.dart';
import 'package:flutter_development_task/screens/project_screen.dart';

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  int _selectedIndex = 2;
  String _selectedPage = 'Individual Meetup';

  // List of pages to display for each BottomNavigationBar item
  static List<Widget> _pages = <Widget>[
    const HomeScreen(),
    const ProjectScreen(),
    const MeetupScreen(),
    const ExploreScreen(),
    const AccountScreen(),
  ];
  static List<String> _pageeName = <String>["Home", "Project", "Individual Meetup", "Explore", "Account"];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedPage = _pageeName.elementAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex, // Display the selected page
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.grid_view_rounded), label: 'Project'),
          BottomNavigationBarItem(icon: Icon(Icons.handshake_outlined), label: 'Meetup'),
          BottomNavigationBarItem(icon: Icon(Icons.plagiarism_outlined), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Account'),
        ],
        currentIndex: _selectedIndex,
        // Current selected index
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped, // Handle index changes
      ),
    );
  }
}
