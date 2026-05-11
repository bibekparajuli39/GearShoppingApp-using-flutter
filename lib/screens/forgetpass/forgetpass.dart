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
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          width: 500,

          alignment: Alignment.center,

          decoration: BoxDecoration(
            border: Border.all(
              color: const Color.fromARGB(255, 187, 217, 243),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color.fromARGB(
                  255,
                  174,
                  206,
                  232,
                ).withValues(alpha: 0.3),
                spreadRadius: 2,
                blurRadius: 25,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Please enter your email to receive a password reset link.',
                style: TextStyle(fontSize: 17),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 1,
                      vertical: 10,
                    ),
                    labelText: 'Enter a email',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  backgroundColor: const Color.fromARGB(255, 88, 141, 232),
                ),
                child: Text('Send Link', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
