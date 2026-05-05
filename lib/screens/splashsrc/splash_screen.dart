import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gearapp/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, AppRoutes.wrap);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Gear App')));
  }
}
