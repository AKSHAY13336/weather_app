import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _usernameController = TextEditingController(); // 🔑 CHANGED: From email to username
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose(); // 🔑 CHANGED: Dispose username controller
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    final username = _usernameController.text.trim(); // 🔑 CHANGED: Variable
    final password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) { // 🔑 CHANGED: Check username
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter username and password')), // 🔑 CHANGED: Message
        );
      }
      return;
    }

    // Save credentials
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', username); // 🔑 CHANGED: Key is 'username'
    await prefs.setString('password', password);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Signup successful!')),
      );

      Navigator.pushReplacementNamed(context, '/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: const EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.cloud_queue,
                        size: 80, color: Colors.blueAccent),
                    const SizedBox(height: 20),
                    const Text(
                      'ClimaCast Signup',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 30),
                    TextField(
                      controller: _usernameController, // 🔑 CHANGED: Controller
                      decoration: const InputDecoration(
                        labelText: 'Username', // 🔑 CHANGED: Label
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person), // 🔑 CHANGED: Icon
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton(
                      onPressed: _signup,
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: const Text(
                        'Signup',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacementNamed(context, '/login');
                      },
                      child: const Text('Already have an account? Login'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}