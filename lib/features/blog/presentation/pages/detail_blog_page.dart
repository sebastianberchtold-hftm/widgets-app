import 'package:flutter/material.dart';

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
