import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController(); // 🔑 CHANGED: From email to username
  final _passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void initState() {
    super.initState();
    _autoLogin();
    _loadSavedCredentials();
  }
  
  @override
  void dispose() {
    _usernameController.dispose(); // 🔑 CHANGED: Dispose username controller
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _autoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username'); // 🔑 CHANGED: Key is 'username'
    final savedPassword = prefs.getString('password');
    if (savedUsername != null && savedPassword != null) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    }
  }

  Future<void> _loadSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username'); // 🔑 CHANGED: Key is 'username'
    final savedPassword = prefs.getString('password');
    if (savedUsername != null) _usernameController.text = savedUsername; // 🔑 CHANGED: Controller
    if (savedPassword != null) _passwordController.text = savedPassword;
  }

  Future<void> _login() async {
    final enteredUsername = _usernameController.text.trim(); // 🔑 CHANGED: Variable
    final enteredPassword = _passwordController.text;
    
    if (enteredUsername.isEmpty || enteredPassword.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter username and password')), // 🔑 CHANGED: Message
        );
      }
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final savedUsername = prefs.getString('username') ?? ''; // 🔑 CHANGED: Key is 'username'
    final savedPassword = prefs.getString('password') ?? '';

    if (enteredUsername == savedUsername && enteredPassword == savedPassword) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/home');
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid credentials')),
        );
      }
    }
  }

  Future<void> _googleLogin() async {
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', account.email); // 🔑 CHANGED: Key is 'username'
        await prefs.setString('password', 'google');
        if (mounted) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Google Sign-In failed')),
        );
      }
    }
  }

  void _forgetPassword() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Forgot Password'),
        content: const Text(
            'Please contact support@climacast.com to reset your password.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          )
        ],
      ),
    );
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
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.cloud, size: 100, color: Colors.white),
                    SizedBox(height: 20),
                    Text(
                      'ClimaCast Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(25),
                  child: Column(
                    children: [
                      TextField(
                        controller: _usernameController, // 🔑 CHANGED: Controller
                        decoration: const InputDecoration(
                          labelText: 'Username', // 🔑 CHANGED: Label
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person), // 🔑 CHANGED: Icon
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.lock),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: _forgetPassword,
                          child: const Text('Forgot Password?'),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Login button
                      ElevatedButton(
                        onPressed: _login,
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
                          'Login',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 15),
                      // Google Sign-in
                      ElevatedButton.icon(
                        onPressed: _googleLogin,
                        icon: Image.network(
                          'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                          height: 24,
                          width: 24,
                        ),
                        label: const Text('Sign in with Google'),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 50),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        },
                        child:
                            const Text('Don\'t have an account? Sign up here'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}