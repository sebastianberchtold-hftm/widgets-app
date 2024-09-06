import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../blog/presentation/pages/blog_list_page.dart';
import 'sign_in_page.dart';

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasData) {
          // User is signed in
          return BlogListPage();
        } else {
          // User is not signed in
          return SignInPage();
        }
      },
    );
  }
}
