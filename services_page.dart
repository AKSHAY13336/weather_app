import 'package:flutter/material.dart';
// import '../widgets/drawer_widget.dart'; // REMOVED

// Class renamed to be the body content only
class ServicesPageContent extends StatelessWidget {
  const ServicesPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold, AppBar, and Drawer REMOVED. Only body content is returned.
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Icon(Icons.miscellaneous_services, size: 100, color: Colors.blueAccent),
            ),
            const SizedBox(height: 20),

            const Text(
              '🌟 ClimaCast Services',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'ClimaCast offers a range of weather-related services to keep you informed and prepared:',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 20),

            const ListTile(
              leading: Icon(Icons.thermostat, color: Colors.blueAccent),
              title: Text('Real-time temperature, humidity & wind speed updates'),
            ),
            const ListTile(
              leading: Icon(Icons.calendar_today, color: Colors.blueAccent),
              title: Text('5-day weather forecasts with daily details'),
            ),
            const ListTile(
              leading: Icon(Icons.warning_amber_rounded, color: Colors.blueAccent),
              title: Text('Severe weather alerts & notifications'),
            ),
            const ListTile(
              leading: Icon(Icons.map, color: Colors.blueAccent),
              title: Text('City-based weather search with accurate data'),
            ),
            const ListTile(
              leading: Icon(Icons.cloud_queue, color: Colors.blueAccent),
              title: Text('Weather insights including cloud cover and conditions'),
            ),
            const ListTile(
              leading: Icon(Icons.phone_android, color: Colors.blueAccent),
              title: Text('Clean, modern interface with smooth navigation'),
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
              'All weather data is powered by the OpenWeatherMap API. Ensure you have a stable internet connection to get real-time updates.',
              style: TextStyle(fontSize: 16, height: 1.5),
            ),
          ],
        ),
      );
  }
}