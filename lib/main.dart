import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

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

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog List'),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No blogs available.'));
          }

          List<QueryDocumentSnapshot> blogs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              var blogData = blogs[index].data() as Map<String, dynamic>;
              return ListTile(
                title: Text(blogData['title'] ?? 'No Title'),
                subtitle: Text(blogData['content'] ?? 'No Content'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BlogDetailPage(blogData: blogData),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}

class BlogDetailPage extends StatelessWidget {
  final Map<String, dynamic> blogData;

  const BlogDetailPage({Key? key, required this.blogData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(blogData['title'] ?? 'No Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blogData['title'] ?? 'No Title',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
                'Published on: ${blogData['publishedDateString'] ?? 'Unknown Date'}'),
            SizedBox(height: 16),
            Text(blogData['content'] ?? 'No Content',
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
