import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'features/blog/presentation/pages/blog_list_page.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions
        .currentPlatform, // Use platform-specific Firebase config
  );
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlogListPage(),
    );
  }
}
