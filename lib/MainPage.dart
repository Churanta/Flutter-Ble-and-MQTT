import 'package:flutter/material.dart';
import 'package:heat_pump/Dashboard.dart';
import 'package:heat_pump/about_user.dart';
import 'package:heat_pump/providers/authProvider.dart';
import 'package:provider/provider.dart';

import 'button_page.dart';
import 'login.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample({Key? key}) : super(key: key);

  @override
  _NavigationExampleState createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample>
    with TickerProviderStateMixin {
  int currentPageIndex = 0;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _navigateToPage(int index) {
    if (index != currentPageIndex) {
      setState(() {
        currentPageIndex = index;
      });
      _animationController.forward(from: 0);
    }
  }

  Widget _buildIconWithDash(int index, IconData icon, String label) {
    final isSelected = index == currentPageIndex;
    return Stack(
      alignment: Alignment.bottomCenter, // Align stack items to the bottom
      children: [
        Icon(
          icon,
          color: isSelected ? Colors.white : Colors.grey[400],
          size: 24.0,
        ),
        if (isSelected)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 30.0,
                height: 4.0,
                margin: const EdgeInsets.only(
                    bottom: 25), // Add margin to separate line from icon
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(
                      2.0), // Adjust border radius for the line
                ),
                transform: Matrix4.translationValues(
                  -25.0 +
                      (24.0 *
                          _animation
                              .value), // Translate line horizontally based on animation value
                  0.0,
                  0.0,
                ),
              );
            },
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          <Widget>[
            ButtonPage(),
            const AboutUser(),
          ][currentPageIndex],
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: 60.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.grey[900], // Dark background color
                    selectedItemColor:
                        Colors.white, // Selected icon and text color
                    unselectedItemColor:
                        Colors.grey[400], // Unselected icon and text color
                    currentIndex: currentPageIndex,
                    onTap: _navigateToPage,
                    items: [
                      BottomNavigationBarItem(
                        icon: _buildIconWithDash(
                          0,
                          Icons.home_outlined,
                          'Home',
                        ),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: _buildIconWithDash(
                          1,
                          Icons.person_outlined,
                          'User',
                        ),
                        label: 'User',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
