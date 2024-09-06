import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  final String title;
  final String content;
  final String author;
  final String? imageUrl;
  final String publishedDate;

  const BlogDetailPage({
    Key? key,
    required this.title,
    required this.content,
    required this.author,
    this.imageUrl,
    required this.publishedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageUrl != null && imageUrl!.isNotEmpty
                ? Image.network(imageUrl!, height: 200, fit: BoxFit.cover)
                : Icon(Icons.image,
                    size: 100), // Default image icon if no image
            SizedBox(height: 20),
            Text(
              'By $author',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Published on $publishedDate',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            Text(
              content,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
