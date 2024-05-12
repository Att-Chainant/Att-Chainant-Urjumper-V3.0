import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'forgot_pw_page.dart';  // Ensure you have this page or adjust accordingly

class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;  // Callback to toggle to the registration page
  const LoginPage({super.key, required this.showRegisterPage});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();  // Controller for email input
  final TextEditingController _passwordController = TextEditingController();  // Controller for password input
  bool _isLoading = false;  // State indicator for loading during sign in

  // Function to handle user sign-in using Firebase authentication
  Future<void> signIn() async {
    if (!_validateInput()) return; // Validate input before attempting to sign in

    setState(() {
      _isLoading = true;  // Show loading indicator
    });
    try {
      // Attempt to sign in user with email and password
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      Navigator.of(context).pushReplacementNamed('/home');  // Navigate to home page on success
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? "Login failed")),  // Show error message on failure
      );
    } finally {
      setState(() {
        _isLoading = false;  // Hide loading indicator
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();  // Clean up the controller when the widget is disposed
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],  // Background color
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.asset('lib/images/urjumper-logo.png'),  // App logo
                const SizedBox(height: 5),
                Text(
                  'URJUMPER',
                  style: GoogleFonts.manrope(fontSize: 40, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 20),
                _buildEmailTextField(),  // Email input field
                const SizedBox(height: 13),
                _buildPasswordTextField(),  // Password input field
                const SizedBox(height: 8),
                _buildForgotPasswordButton(context),  // Forgot password button
                const SizedBox(height: 8),
                _isLoading ? CircularProgressIndicator() : _buildSignInButton(),  // Conditional display of the sign-in button or loading indicator
                const SizedBox(height: 13),
                _buildRegisterNowButton(),  // Register now button
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailTextField() {
    return Padding(
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
  }

  Widget _buildPasswordTextField() {
    return Padding(
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
            obscureText: true,
            decoration: const InputDecoration(
              border: InputBorder.none,
              hintText: 'Password',
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const ForgotPasswordPage()));
        },
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.blueAccent, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: signIn,
        child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Colors.greenAccent,
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Center(
            child: Text(
              'Sign In',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRegisterNowButton() {
    return Row(
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
}
