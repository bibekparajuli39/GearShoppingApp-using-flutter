import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gearapp/provider/category_provider.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => signOut(),
        child: const Icon(Icons.login_rounded),
      ),
    );
  }
}
