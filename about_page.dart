import 'package:flutter/material.dart';

class AboutPageContent extends StatelessWidget {
  const AboutPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    // Only body content (no Scaffold) since wrapper handles layout
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Icon(Icons.cloud, size: 100, color: Colors.blueAccent),
          ),
          const SizedBox(height: 20),

          const Text(
            '🌦️ About ClimaCast',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'ClimaCast is a modern weather forecast application designed to provide real-time weather updates and accurate forecasts for cities all around the world. '
            'Built with Flutter and powered by the OpenWeatherMap API, ClimaCast helps you stay prepared for any weather condition with just a few taps.',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
          const SizedBox(height: 30),

          const Text(
            '👨‍💼 Leadership Team',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),

          // CEO Profile
          _buildProfileCard(
            name: 'J Akshay',
            role: 'Chief Executive Officer (CEO)',
            description:
                'Leads ClimaCast with vision, driving the team to innovate in weather forecasting solutions and ensuring exceptional user experiences.',
            imageUrl:
                'https://cdn-icons-png.flaticon.com/512/3135/3135715.png',
          ),

          // CTO Profile
          _buildProfileCard(
            name: 'K Devender',
            role: 'Chief Technology Officer (CTO)',
            description:
                'Heads the technology strategy, overseeing development and innovation of ClimaCast’s core features and infrastructure.',
            imageUrl:
                'https://cdn-icons-png.flaticon.com/512/3135/3135768.png',
          ),

          // COO Profile
          _buildProfileCard(
            name: 'K Vinod',
            role: 'Chief Operating Officer (COO)',
            description:
                'Manages daily operations, ensuring smooth coordination and effective execution across all departments.',
            imageUrl:
                'https://cdn-icons-png.flaticon.com/512/3135/3135789.png',
          ),

          const SizedBox(height: 30),

          const Text(
            '✨ Features',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 10),
          const ListTile(
            leading: Icon(Icons.thermostat, color: Colors.blueAccent),
            title: Text('Real-time temperature, humidity & wind speed'),
          ),
          const ListTile(
            leading: Icon(Icons.calendar_today, color: Colors.blueAccent),
            title: Text('5-day weather forecast with daily details'),
          ),
          const ListTile(
            leading: Icon(Icons.notifications_active, color: Colors.blueAccent),
            title: Text('Severe weather alerts & updates'),
          ),
          const ListTile(
            leading: Icon(Icons.phone_android, color: Colors.blueAccent),
            title: Text('Modern UI with smooth navigation'),
          ),
        ],
      ),
    );
  }

  /// Helper Widget: Profile Card
  Widget _buildProfileCard({
    required String name,
    required String role,
    required String description,
    required String imageUrl,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 35,
              backgroundImage: NetworkImage(imageUrl),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    role,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
