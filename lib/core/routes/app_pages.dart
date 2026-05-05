import 'package:flutter/cupertino.dart';
import 'package:gearapp/core/routes/app_routes.dart';
import 'package:gearapp/screens/cart/cart_screen.dart';
import 'package:gearapp/screens/forgetpass/forgetpass.dart';
import 'package:gearapp/screens/home/home_screen.dart';
import 'package:gearapp/screens/login/auth_wrapper.dart';
import 'package:gearapp/screens/login/login_screen.dart';
import 'package:gearapp/screens/login/signup_screen.dart';
import 'package:gearapp/screens/maintab_screen.dart';
import 'package:gearapp/screens/profile/profile_screen.dart';
import 'package:gearapp/screens/splashsrc/splash_screen.dart';

class AppPages {
  static Map<String, WidgetBuilder> routes = {
    AppRoutes.splash: (context) => SplashScreen(),
    AppRoutes.home: (context) => const HomeScreen(),
    AppRoutes.login: (context) => const LoginScreen(),
    AppRoutes.profile: (context) => const ProfileScreen(),
    AppRoutes.signup: (context) => const SignupScreen(),
    AppRoutes.cart: (context) => const CartScreen(),
    AppRoutes.main: (context) => const MaintabScreen(),
    AppRoutes.wrap: (context) => const AuthWrapper(),
    AppRoutes.forget: (context) => const Forgetpass(),
  };
}
