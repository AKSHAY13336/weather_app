import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/main_wrapper_page.dart'; // ✅ New import. Ensures file path is correct.

// The following imports are no longer needed, as they are managed by MainWrapperPage:
// import 'pages/home_page.dart';
// import 'pages/about_page.dart';
// import 'pages/services_page.dart';
// import 'pages/notifications_page.dart';
// import 'pages/contact_page.dart';

void main() {
  runApp(const ClimaCastApp());
}

class ClimaCastApp extends StatelessWidget {
  const ClimaCastApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  title: 'ClimaCast',
  theme: ThemeData(
    primarySwatch: Colors.blue,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
    ),
  ),
  debugShowCheckedModeBanner: false,
  initialRoute: '/login',
  routes: {
    '/login': (context) => const LoginPage(),
    '/signup': (context) => const SignupPage(),
    '/home': (context) => const MainWrapperPage(), // ✅ Route now points to the new wrapper
    // Removed redundant content page routes: /about, /services, etc.
  },
);

  }
}