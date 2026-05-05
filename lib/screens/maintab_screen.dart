import 'package:flutter/material.dart';
import 'package:gearapp/screens/cart/cart_screen.dart';
import 'package:gearapp/screens/home/home_screen.dart';
import 'package:gearapp/screens/profile/profile_screen.dart';

class MaintabScreen extends StatefulWidget {
  const MaintabScreen({super.key});

  @override
  State<MaintabScreen> createState() => _MaintabScreenState();
}

class _MaintabScreenState extends State<MaintabScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [HomeScreen(), CartScreen(), ProfileScreen()];

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    // 📱 MOBILE UI
    if (width < 600) {
      return Scaffold(
        body: IndexedStack(index: _currentIndex, children: _pages),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      );
    }

    // 💻 TABLET / WEB UI
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) =>
                setState(() => _currentIndex = index),
            labelType: NavigationRailLabelType.all,
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home),
                label: Text('Home'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.shopping_cart),
                label: Text('Cart'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.person),
                label: Text('Profile'),
              ),
            ],
          ),

          // Main Content
          Expanded(
            child: IndexedStack(index: _currentIndex, children: _pages),
          ),
        ],
      ),
    );
  }
}
