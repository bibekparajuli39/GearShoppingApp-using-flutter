import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/core/routes/app_routes.dart';
import 'package:gearapp/screens/login/signup_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future<void> signIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      if (!mounted) return;
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('login succesful'),
            backgroundColor: Color.fromARGB(255, 71, 213, 75),
            duration: Duration(seconds: 1),
          ),
        );
        Navigator.pushNamed(context, AppRoutes.main);
      }
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      String message = 'login failed';

      if (e.code == 'user-not-found') {
        message = 'No user found';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-credential') {
        message = 'Incorrect email and password';
      } else if (e.code == 'invalid-email') {
        message = 'Incorrect email';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  //it always dispose
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObscured = ref.watch(passwordVisivility);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(10),
            constraints: const BoxConstraints(maxWidth: 400),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 1),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromARGB(
                    255,
                    255,
                    255,
                    255,
                  ).withValues(alpha: 0.3),
                  spreadRadius: 2,
                  blurRadius: 4,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            margin: EdgeInsets.symmetric(
              horizontal: width > 900 ? width * 0.2 : 30,
              vertical: 30,
            ),
            width: width > 600 ? 400 : width * 0.9,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(0),
                  child: Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      TextField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email_rounded),
                          labelText: 'Enter your email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 250, 247, 247),
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: passwordController,
                        obscureText: isObscured,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.password_rounded),
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(passwordVisivility.notifier).state =
                                  !isObscured;
                            },
                            icon: Icon(
                              isObscured
                                  ? Icons.visibility_off_rounded
                                  : Icons.visibility_rounded,
                            ),
                          ),
                          labelText: 'Enter your password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 250, 247, 247),
                        ),
                      ),
                      SizedBox(height: 20),
                      MyButton(text: 'Login', onPressed: () => signIn()),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.topRight,

                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, AppRoutes.forget);
                          },
                          child: Text(
                            'Forget Password?',
                            textAlign: TextAlign.right,
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, AppRoutes.signup);
                            },
                            child: Text(
                              'Sign up',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyButton({super.key, required this.text, required this.onPressed});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          backgroundColor: const Color.fromARGB(255, 88, 141, 232),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
