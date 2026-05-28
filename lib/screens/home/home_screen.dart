import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gearapp/provider/category_provider.dart';
import 'package:gearapp/provider/productprovider.dart';
import 'package:gearapp/screens/catagories/categories_screen.dart';
import 'package:gearapp/screens/products/product_list_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    final selectedCategory = ref.watch(selectedCategoryProvider);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 10),

              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  'assets/logo.jpg',
                  height: 70,
                  width: 200,

                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Search',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                style: TextStyle(color: Colors.white),
                onChanged: (value) {
                  ref.read(searchProvider.notifier).state = value;
                },
                decoration: InputDecoration(
                  hintText: 'Search products....',
                  hintStyle: const TextStyle(color: Colors.white),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: const Icon(Icons.search, color: Colors.white),
                  filled: true,
                  fillColor: const Color.fromARGB(255, 60, 157, 236),
                ),
              ),
            ),

            SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Welcome to Gear product',
                    style: TextStyle(fontSize: 18),
                  ),
                  Text(
                    user?.displayName ?? 'Guest',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            const CategoriesScreen(),
            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedCategory ?? 'All Products',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (selectedCategory != null)
                    GestureDetector(
                      onTap: () =>
                          ref.read(selectedCategoryProvider.notifier).state =
                              null,
                      child: const Text(
                        'Clear',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ),
                ],
              ),
            ),

            Expanded(
              child: ProductListScreen(
                userId: user?.uid ?? '',
                categoryName: selectedCategory,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOut(),
        child: const Icon(Icons.login_rounded),
      ),
    );
  }
}
