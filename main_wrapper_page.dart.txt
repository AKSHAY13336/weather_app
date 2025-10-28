import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// Import the content-only versions of your pages
import 'home_page.dart';
import 'about_page.dart';
import 'services_page.dart';
import 'notifications_page.dart';
import 'contact_page.dart';

class MainWrapperPage extends StatefulWidget {
  const MainWrapperPage({super.key});

  @override
  State<MainWrapperPage> createState() => _MainWrapperPageState();
}

class _MainWrapperPageState extends State<MainWrapperPage> {
  int _currentIndex = 0;

  // List of content widgets to switch between
  final List<Widget> _pages = const [
    HomePageContent(),
    AboutPageContent(),
    ServicesPageContent(),
    NotificationsPageContent(),
    ContactPageContent(),
  ];

  // Titles for the AppBar
  final List<String> _titles = const [
    'ClimaCast - Weather Forecast',
    'About ClimaCast',
    'Our Services',
    'Notifications',
    'Contact Us',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<void> _logout() async {
    // Clear saved login credentials
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Navigate to Login and remove all previous routes
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
          context, '/login', (Route<dynamic> route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        // Logout moved from the Drawer to the AppBar
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: _logout,
          ),
        ],
      ),
      // Display the selected page content
      body: _pages[_currentIndex],
      // The new horizontal navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Ensures all items are visible
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Alerts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contact_mail),
            label: 'Contact',
          ),
        ],
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}