import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gearapp/core/routes/app_routes.dart';

import 'package:gearapp/screens/products/product_list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            hintText: 'Search products....',
            hintStyle: const TextStyle(color: Colors.white),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none,
            ),
            suffixIcon: const Icon(Icons.search, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 10, 108, 255),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: const Text(
              'Welcome to Gear Products',
              style: TextStyle(fontSize: 18),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.login);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 86, 168, 234),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
              child: const Text(
                'Login/Sign Up',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Expanded is needed here so the GridView inside ProductListScreen can scroll
          const Expanded(child: ProductListScreen()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOut(),
        child: Icon(Icons.login_rounded),
      ),
    );
  }
}
