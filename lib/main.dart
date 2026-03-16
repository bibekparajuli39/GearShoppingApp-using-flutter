import 'package:flutter/material.dart';
import 'package:gearapp/core/routes/app_pages.dart';
import 'package:gearapp/core/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping App',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splash,
      routes: AppPages.routes,
    );
  }
}
