import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../controlles/authentication.dart'; // Make sure to import your AuthService

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService =
      AuthService(); // Create an instance of AuthService

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                hintText: "example@mail.com",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String email = _emailController.text.trim();
                String password = _passwordController.text.trim();

                // Use the AuthService's sign-in method
                User? user = await _authService.signInWithEmailAndPassword(
                    email, password, context);
                if (user != null) {
                  Navigator.pushReplacementNamed(
                      context, '/'); // Navigate to the home page on success
                }
              },
              child: Text('Sign In'),
            ),
          ],
        ),
      ),
    );
  }
}
