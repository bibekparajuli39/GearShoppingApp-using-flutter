import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Forgetpass extends ConsumerStatefulWidget {
  const Forgetpass({super.key});

  @override
  ConsumerState<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends ConsumerState<Forgetpass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text('Forget Password')));
  }
}
