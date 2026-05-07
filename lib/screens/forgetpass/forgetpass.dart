import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/screens/login/authprovider.dart';

class Forgetpass extends ConsumerStatefulWidget {
  const Forgetpass({super.key});

  @override
  ConsumerState<Forgetpass> createState() => _ForgetpassState();
}

class _ForgetpassState extends ConsumerState<Forgetpass> {
  final emailController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forget Password')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: 'Enter a email',
                border: OutlineInputBorder(borderRadius: BorderRadius.zero),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                final authService = ref.watch(authServiceProvider);

                await authService.reset(emailController.text);
                if (mounted) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('send link to the email'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                backgroundColor: const Color.fromARGB(255, 88, 141, 232),
              ),
              child: Text('Send Link', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
