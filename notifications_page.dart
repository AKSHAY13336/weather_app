import 'package:flutter/material.dart';
// import '../widgets/drawer_widget.dart'; // REMOVED

// Class renamed to be the body content only
class NotificationsPageContent extends StatelessWidget {
  const NotificationsPageContent({super.key});

  // Mock notifications data
  final List<Map<String, String>> notifications = const [
    {
      'title': 'Severe Weather Alert',
      'message': 'Thunderstorm expected tomorrow in Mumbai.',
      'date': '2025-10-14 08:00 AM',
    },
    {
      'title': 'Daily Forecast Ready',
      'message': 'Check today\'s weather forecast for Delhi.',
      'date': '2025-10-13 07:30 AM',
    },
    {
      'title': 'App Update',
      'message': 'ClimaCast version 1.1 is now available.',
      'date': '2025-10-12 09:00 PM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    // Scaffold, AppBar, and Drawer REMOVED. Only body content is returned.
    return notifications.isEmpty
          ? const Center(
              child: Text(
                'No new notifications',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: ListTile(
                    leading: const Icon(Icons.notifications, color: Colors.blueAccent),
                    title: Text(notification['title']!),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['message']!),
                        const SizedBox(height: 5),
                        Text(
                          notification['date']!,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
  }
}