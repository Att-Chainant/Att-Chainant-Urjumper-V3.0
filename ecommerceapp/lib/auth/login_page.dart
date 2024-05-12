import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_pw_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  // Function to handle user sign-in using Firebase authentication
  Future<void> signIn() async {
    if (!_validateInput()) return; // Validate input before signing in

    setState(() {
      _isLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      setState(() {
        _isLoading = false;
      });
      // Navigate to the next screen if the login is successful
    } on FirebaseAuthException catch (e) {
      setState(() {
        _isLoading = false;
      });
      // Show error message if login fails
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),
      );
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // Light grey color background
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView( // Allows the form to be scrollable
            child: Column(
              children: [
                Image.asset('lib/images/urjumper-logo.png'), // Display logo
                const SizedBox(height: 5),
                Text(
                  'URJUMPER', // Display the app name prominently
                  style: GoogleFonts.manrope(
                    fontSize: 40,
                    fontWeight: FontWeight.w800
                  ),
                ),
                const SizedBox(height: 20),
                _buildEmailTextField(), // Email input field
                const SizedBox(height: 13),
                _buildPasswordTextField(), // Password input field
                const SizedBox(height: 8),
                _buildForgotPassword(context), // Forgot password link
                const SizedBox(height: 8),
                _isLoading ? CircularProgressIndicator() : _buildSignInButton(), // Show loading indicator or sign-in button
                const SizedBox(height: 13),
                _buildRegisterNow(), // Link to switch to the registration page
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Validate email and password input before attempting to sign in
  bool _validateInput() {
    if (_emailController.text.isEmpty || !_emailController.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please enter a valid email address")),
      );
      return false;
    }
    if (_passwordController.text.isEmpty || _passwordController.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Password must be at least 6 characters long")),
      );
      return false;
    }
    return true;
  }

  Widget _buildEmailTextField() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          controller: _emailController,
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Email Address',
          ),
        ),
      ),
    ),
  );

  Widget _buildPasswordTextField() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: TextField(
          controller: _passwordController,
          obscureText: true, // Hides the password as it is entered
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Password',
          ),
        ),
      ),
    ),
  );

  Widget _buildForgotPassword(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage())),
          child: const Text(
            'Forgot Password?',
            style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    ),
  );

  Widget _buildSignInButton() => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25),
    child: GestureDetector(
      onTap: signIn,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(20)
        ),
        child: const Center(
          child: Text(
            'Sign In',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
          )),
      ),
    ),
  );

  Widget _buildRegisterNow() => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Text('Not a member?', style: TextStyle(color: Colors.black87)),
      GestureDetector(
        onTap: widget.showRegisterPage,
        child: const Text(' Register now', style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold)),
      ),
    ],
  );
}
