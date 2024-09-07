import 'package:flutter/material.dart';

class BlogTile extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String author;
  final int likes;
  final VoidCallback onTap;

  BlogTile({
    required this.imageUrl,
    required this.title,
    required this.author,
    required this.likes,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    print('Image URL in BlogTile: $imageUrl');

    return ListTile(
      leading: imageUrl.isNotEmpty
          ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
          : Icon(Icons.image, size: 50),
      title: Text(title),
      subtitle: Text('By $author • $likes likes'),
      onTap: onTap,
    );
  }
}
