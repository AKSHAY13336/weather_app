import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
// import '../widgets/drawer_widget.dart'; // REMOVED

// Class renamed to be the body content only
class HomePageContent extends StatefulWidget {
  const HomePageContent({super.key});

  @override
  State<HomePageContent> createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final TextEditingController _cityController = TextEditingController();
  final String apiKey = '9ca100e3b0d160e4876e9328c47d2fdc'; // 🔑 Replace with your OpenWeatherMap key
  bool isLoading = false;
  String cityName = '';
  List<dynamic> forecastList = [];

  Future<void> fetchWeather() async {
  final city = _cityController.text.trim();
  if (city.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please enter a city name')),
    );
    return;
  }

  setState(() {
    isLoading = true;
    forecastList = [];
  });

  final url = Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=$city&appid=$apiKey&units=metric');

  try {
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        cityName = data['city']['name'];
        forecastList = (data['list'] as List)
            .where((item) => (item as Map<String, dynamic>)['dt_txt']
                .toString()
                .contains('12:00:00'))
            .toList();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('City not found or invalid API key')),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error fetching data: $e')),
    );
  } finally {
    setState(() => isLoading = false);
  }
}


  @override
  Widget build(BuildContext context) {
    // Scaffold, AppBar, and Drawer REMOVED. Only body content is returned.
    return SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 10),
            const Text(
              'Check the Weather Forecast 🌦️',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _cityController,
              decoration: InputDecoration(
                labelText: 'Enter City Name',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.location_city),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: fetchWeather,
              icon: const Icon(Icons.cloud_outlined),
              label: const Text('Get Forecast'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
            const SizedBox(height: 30),

            if (isLoading)
              const CircularProgressIndicator()
            else if (forecastList.isEmpty)
              const Text('Enter a city to get weather forecast.',
                  style: TextStyle(fontSize: 16))
            else ...[
              Text(
                '5-Day Forecast for $cityName',
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),

              // Scrollable forecast cards
              SizedBox(
                height: 220,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: forecastList.length,
                  itemBuilder: (context, index) {
                    final forecast = forecastList[index];
                    final date = forecast['dt_txt'];
                    final temp = forecast['main']['temp'].toDouble();
                    final humidity = forecast['main']['humidity'];
                    final wind = forecast['wind']['speed'];
                    final description =
                        forecast['weather'][0]['description'];
                    final iconCode = forecast['weather'][0]['icon'];

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                      child: Container(
                        width: 160,
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              date.split(' ')[0],
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent),
                            ),
                            const SizedBox(height: 8),
                            Image.network(
                              'https://openweathermap.org/img/wn/$iconCode@2x.png',
                              width: 60,
                              height: 60,
                            ),
                            Text(
                              '${temp.toStringAsFixed(1)}°C',
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87),
                            ),
                            const SizedBox(height: 4),
                            Text(description,
                                style: const TextStyle(
                                    fontSize: 14, color: Colors.grey)),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.water_drop,
                                    size: 16, color: Colors.blue),
                                Text(' $humidity%  '),
                                const Icon(Icons.air,
                                    size: 16, color: Colors.green),
                                Text(' ${wind}m/s'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      );
  }
}