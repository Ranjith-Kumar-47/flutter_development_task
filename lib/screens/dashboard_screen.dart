import 'package:flutter/material.dart';
import 'package:flutter_development_task/screens/account_screen.dart';
import 'package:flutter_development_task/screens/explore_screen.dart';
import 'package:flutter_development_task/screens/home_screen.dart';
import 'package:flutter_development_task/screens/meetup_screen.dart';
import 'package:flutter_development_task/screens/project_screen.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<DashboardPage> {
  int _currentIndex = 2;
  final List<Widget> _pages = [
    const NavigatorPage(child: HomeScreen()),
    const NavigatorPage(child: ProjectScreen()),
    const NavigatorPage(child: MeetupScreen()),
    const NavigatorPage(child: ExploreScreen()),
    const NavigatorPage(child: AccountScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
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
        currentIndex: _currentIndex,
        // Current selected index
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        onTap: (index) => setState(() => _currentIndex = index), // Handle index changes
      ),
    );
  }
}

class NavigatorPage extends StatelessWidget {
  final Widget child;

  const NavigatorPage({required this.child});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => child,
        );
      },
    );
  }
}
