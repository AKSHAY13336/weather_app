import 'package:flutter/material.dart';
// import '../widgets/drawer_widget.dart'; // REMOVED

// Class renamed to be the body content only
class ContactPageContent extends StatelessWidget {
  const ContactPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold, AppBar, and Drawer REMOVED. Only body content is returned.
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.contact_mail, size: 100, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),

            const Text(
              '📞 Contact ClimaCast',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'We would love to hear from you! Reach out to us for support, feedback, or suggestions:',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            ListTile(
              leading: const Icon(Icons.email, color: Colors.blueAccent),
              title: const Text('Email'),
              subtitle: const Text('support@climacast.com'),
              onTap: () {
                // Optionally open email app
              },
            ),
            ListTile(
              leading: const Icon(Icons.phone, color: Colors.blueAccent),
              title: const Text('Phone'),
              subtitle: const Text('+91 12345 67890'),
              onTap: () {
                // Optionally open phone dialer
              },
            ),
            ListTile(
              leading: const Icon(Icons.web, color: Colors.blueAccent),
              title: const Text('Website'),
              subtitle: const Text('https://www.climacast.com'),
              onTap: () {
                // Optionally open browser
              },
            ),

            const SizedBox(height: 25),
            const Text(
              '💡 Note',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'For best support, please contact us via email. We aim to respond within 24 hours.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      );
  }
}