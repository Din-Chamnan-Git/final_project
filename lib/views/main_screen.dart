import 'package:final_project/const/themes/app_theme.dart';
import 'package:final_project/views/home_screen.dart';
import 'package:final_project/views/search_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  List<Widget> pages = [HomeScreen(), SearchPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: Container(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: GNav(
            padding: EdgeInsets.all(12),
            gap: 8,
            activeColor: AppThemeData.primaryBlueAccent,
            tabBackgroundColor: AppThemeData.primarySoft,
            tabs: [
              GButton(icon: Icons.home, text: "home"),
              GButton(icon: Icons.search, text: "Search"),
              GButton(icon: Icons.file_download_outlined, text: "Faorite"),
              GButton(icon: Icons.person, text: "Profile"),
            ],
            selectedIndex: _currentIndex,
            onTabChange: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }
}
