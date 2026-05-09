import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:gearapp/screens/login/authprovider.dart';
import 'package:gearapp/screens/login/login_screen.dart';
import 'package:gearapp/screens/maintab_screen.dart';

class AuthWrapper extends ConsumerStatefulWidget {
  const AuthWrapper({super.key});

  @override
  ConsumerState<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends ConsumerState<AuthWrapper> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authprovider);
    return auth.when(
      data: (user) => user != null ? MaintabScreen() : LoginScreen(),
      error: (e, _) => Text('error'),
      loading: () => const CircularProgressIndicator(),
    );
  }
}
