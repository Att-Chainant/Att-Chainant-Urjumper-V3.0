import 'package:flutter/material.dart';
import 'login_page.dart';
import 'register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Initially show the login page
  bool showLoginPage = true;

  void toggleScreen() {
    setState(() {
      showLoginPage = !showLoginPage;  // Toggle between true and false
    });
  }

  @override
  Widget build(BuildContext context) {
    // Conditional rendering based on 'showLoginPage'
    return showLoginPage
      ? LoginPage(showRegisterPage: toggleScreen)  // Show LoginPage if true
      : RegisterPage(showLoginPage: toggleScreen);  // Show RegisterPage if false
  }
}
