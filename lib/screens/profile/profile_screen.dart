import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gearapp/core/routes/app_routes.dart';
import 'package:gearapp/widgets/listview.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(child: CircleAvatar(child: Icon(Icons.person))),
            TextButton(onPressed: () {}, child: Text('Edit profile')),
            SizedBox(height: 10),
            Text('${user!.email}', style: TextStyle(fontSize: 15)),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: Text(
                'ACCOUNT SETTINGS',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Profiletile(
                    icon: Icons.location_on,
                    title: 'Location',
                    subtitle: 'Add / Edit / Delete addresses',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.address);
                    },
                  ),
                  Profiletile(
                    icon: Icons.shopping_basket,
                    title: 'Orders',
                    subtitle: 'View your orders',
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutes.order);
                    },
                  ),
                  Profiletile(
                    icon: Icons.contact_phone,
                    title: 'Contact',
                    subtitle: 'View your contact information',
                    onTap: () {},
                  ),
                  Profiletile(
                    icon: Icons.contact_support,
                    title: 'Support',
                    onTap: () {},
                    subtitle: 'Get help and support',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
