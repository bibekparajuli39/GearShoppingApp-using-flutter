import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Center(child: CircleAvatar(child: Icon(Icons.person))),
          TextButton(onPressed: () {}, child: Text('Edit profile')),
          SizedBox(height: 10),
          Text('${user!.email}', style: TextStyle(fontSize: 15)),
          SizedBox(height: 10),
          Profiletile(
            icon: Icons.location_on,
            title: 'Location',
            subtitle: 'Add / Edit / Delete addresses',
            onTap: () {},
          ),
          Profiletile(
            icon: Icons.shopping_basket,
            title: 'Orders',
            subtitle: 'View your orders',
            onTap: () {},
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
    );
  }
}
