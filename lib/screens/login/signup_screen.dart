import 'package:flutter/material.dart';
import 'package:gearapp/screens/login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up/Register")),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: width > 600 ? 400 : width * 1,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      'WELCOME TO SIGN UP/REGISTER',
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
                      Row(
                        children: [
                          Expanded(
                            child: MyTextField(
                              text: 'First Name',
                              name: 'name',
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: MyTextField(text: 'Last Name', name: 'name'),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      MyTextField(text: 'Email', name: 'email'),
                      SizedBox(height: 20),
                      MyTextField(text: 'Password', name: 'password'),
                      SizedBox(height: 20),
                      MyButton(text: 'Sign Up', onPressed: () {}),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTextField extends StatelessWidget {
  final String text;
  final String name;

  const MyTextField({super.key, required this.text, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.infinity,
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.zero),
        ),
        keyboardType: name == 'email'
            ? TextInputType.emailAddress
            : TextInputType.text,
        obscureText: name == 'password',
      ),
    );
  }
}
