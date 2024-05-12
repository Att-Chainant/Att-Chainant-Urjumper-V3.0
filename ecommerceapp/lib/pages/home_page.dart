import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/bottom_nav_bar.dart';
import 'cart_page.dart';
import 'shop_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin<HomePage> {
  final FirebaseAuth auth = FirebaseAuth.instance;  // Firebase authentication instance
  User? user;  // Current signed-in user
  String? _username;  // Username of the user
  int _selectedIndex = 0;  // Index for managing bottom navigation bar's selected item
  bool _loading = false;  // Loading state indicator for asynchronous operations

  @override
  void initState() {
    super.initState();
    user = auth.currentUser;
    if (user != null) {
      _loadUsername(); // Load username from Firestore
    } else {
      Navigator.of(context).pushReplacementNamed('/login'); // Navigate to login if no user found
    }
  }

  // Fetches username from Firestore
  Future<void> _loadUsername() async {
    setState(() => _loading = true);
    try {
      var username = await getUsernameForCurrentUser();
      setState(() {
        _username = username;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      print('Error loading username: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading user data.')),
      );
    }
  }

  // Queries Firestore to get the username for the current user
  Future<String?> getUsernameForCurrentUser() async {
    if (user == null || user!.email == null) {
      return null; // Return null if no user is found or user email is not set
    }
    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: user!.email)
        .limit(1)
        .get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.data()['username'] as String?;
    }
    return null;
  }

  // Updates the selected index for the bottom navigation
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Handles user logout
  Future<void> _logout() async {
    try {
      await FirebaseAuth.instance.signOut(); // Attempt to sign out the user
      Navigator.of(context).pushReplacementNamed('/login'); // Redirect to the login page on successful logout
    } catch (e) {
      print('Error signing out: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Logged out.')),
      );
    }
  }

  final List<Widget> _pages = [
    const ShopPage(),
    const CartPage(),
  ];

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), // Show loading indicator during async operations
      );
    }
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Icon(Icons.menu, color: Colors.black),
            ),
            onPressed: () => Scaffold.of(context).openDrawer(), // Open drawer when menu icon is pressed
          ),
        ),
      ),
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: navigateBottomBar,
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(_username ?? 'Guest'), // Display username or 'Guest' if null
              accountEmail: Text(user?.email ?? 'No email available'), // Display email or placeholder
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  _username != null ? _username![0] : "U",
                  style: TextStyle(fontSize: 40.0),
                ),
              ),
            ),
            ListTile(
              title: Text('Home', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.home, color: Colors.white),
              onTap: () => Navigator.of(context).pushReplacementNamed('/home'), // Navigate to home when tapped
            ),
            ListTile(
              title: Text('About', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.info, color: Colors.white),
              onTap: () => Navigator.of(context).pushReplacementNamed('/about'), // Navigate to about when tapped
            ),
            ListTile(
              title: Text('Logout', style: TextStyle(color: Colors.white)),
              leading: Icon(Icons.logout, color: Colors.white),
              onTap: _logout, // Trigger logout when tapped
            ),
          ],
        ),
      ),
      body: _pages[_selectedIndex], // Display the selected page
    );
  }
}
