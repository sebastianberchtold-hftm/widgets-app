import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SlidableBlogTile extends StatelessWidget {
  final String blogId;
  final Map<String, dynamic> blogData;

  const SlidableBlogTile({
    Key? key,
    required this.blogId,
    required this.blogData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;

    return ListTile(
      title: Text(blogData['title']),
      subtitle: Text('By ${blogData['author']}'),
      trailing: currentUser != null && currentUser.uid == blogData['uid']
          ? IconButton(
              icon: Icon(Icons.delete),
              onPressed: () async {
                // Handle deletion with a confirmation dialog
              },
            )
          : null,
    );
  }
}
