import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login/Sign Up')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    'WELCOME TO LOGIN/SIGN UP',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    MyTextField(text: ' Enter your email', name: 'email'),
                    SizedBox(height: 20),
                    MyTextField(text: 'Enter your password', name: 'password'),
                    SizedBox(height: 20),
                    MyButton(text: 'login', onPressed: () {}),
                    SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: MyButton(text: 'Sign Up', onPressed: () {}),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: MyButton(
                            text: 'Forgot Password?',
                            onPressed: () {},
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
      child: TextField(
        decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(),
        ),
        keyboardType: name == 'email'
            ? TextInputType.emailAddress
            : TextInputType.name,
        obscureText: name == 'password' ? true : false,
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          backgroundColor: const Color.fromARGB(255, 88, 141, 232),
        ),
        child: Text(text, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
