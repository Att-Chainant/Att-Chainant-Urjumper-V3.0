import 'package:ecommerceapp/pages/AllShoesPage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerceapp/models/cart.dart';
import 'package:ecommerceapp/pages/main_page.dart'; // Ensure you import the AllShoesPage
import 'package:firebase_core/firebase_core.dart';
import 'package:ecommerceapp/pages/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    ChangeNotifierProvider(
      create: (context) => Cart(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MainPage(),
        '/allShoes': (context) => const AllShoesPage(), // Add this line
        // other routes if necessary
      },
    );
  }
}
