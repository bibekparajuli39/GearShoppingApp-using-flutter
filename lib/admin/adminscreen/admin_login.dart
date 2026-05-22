import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gearapp/admin/adminprovider/adprovider.dart';
import 'package:gearapp/core/routes/app_routes.dart';
import 'package:gearapp/screens/login/signup_screen.dart';

class AdminLogin extends ConsumerStatefulWidget {
  const AdminLogin({super.key});

  @override
  ConsumerState<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends ConsumerState<AdminLogin> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isObscured = ref.watch(passwordVisivility);
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text('admin login')),
      body: Center(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
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
              margin: EdgeInsets.symmetric(horizontal: width > 600 ? 350 : 30),
              width: width > 600 ? 350 : width * 1,
              padding: EdgeInsets.all(40),
              child: Column(
                children: [
                  Text(
                    'Admin login',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: nameController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      labelText: 'Enter a username',
                      prefixIcon: Icon(Icons.person_outline_rounded),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      labelText: 'Enter your password',
                      prefixIcon: Icon(Icons.password),
                      suffixIcon: IconButton(
                        onPressed: () {
                          ref.read(passwordVisivility.notifier).state =
                              !isObscured;
                        },
                        icon: Icon(
                          isObscured
                              ? Icons.visibility_off_rounded
                              : Icons.visibility,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  MyButton(
                    text: 'Login',
                    onPressed: () async {
                      final result = await ref
                          .read(adminService.notifier)
                          .logIn(
                            username: nameController.text.trim(),
                            password: passwordController.text.trim(),
                          );

                      if (!context.mounted) return;

                      if (result == 'success') {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Successfully login')),
                        );

                        Navigator.pushNamed(context, AppRoutes.admindash);
                      } else {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(SnackBar(content: Text(result)));
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
