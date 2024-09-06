import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui_controls_demo/features/blog/presentation/animations/custom_page_route.dart';

import '../../data/repositories/blog_repository.dart';
import '../pages/detail_blog_page.dart';

class SlidableBlogTile extends StatelessWidget {
  final String blogId;
  final Map<String, dynamic> blogData;
  final BlogRepository blogRepository = BlogRepository();

  SlidableBlogTile({
    Key? key,
    required this.blogId,
    required this.blogData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? currentUser = FirebaseAuth.instance.currentUser;
    String imageUrl = blogData['imageUrl'] ?? '';

    return Slidable(
      key: ValueKey(blogId),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          if (currentUser != null && currentUser.uid == blogData['uid'])
            SlidableAction(
              onPressed: (context) async {
                bool confirmDelete = await showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Delete Blog'),
                          content: Text(
                              'Are you sure you want to delete this blog?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: Text('Delete'),
                            ),
                          ],
                        );
                      },
                    ) ??
                    false;

                if (confirmDelete) {
                  await FirebaseFirestore.instance
                      .collection('blogs')
                      .doc(blogId)
                      .delete();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Blog deleted successfully')),
                  );
                }
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
        ],
      ),
      child: GestureDetector(
        onDoubleTap: () async {
          try {
            await blogRepository.likeBlog(blogId);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Liked the blog!')),
            );
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: ListTile(
          leading: imageUrl.isNotEmpty
              ? Image.network(imageUrl,
                  width: 50, height: 50, fit: BoxFit.cover)
              : Icon(Icons.image, size: 50),
          title: Text(blogData['title'] ?? 'Untitled Blog'),
          subtitle: Text(
              'By ${blogData['author'] ?? 'Unknown Author'} • ${blogData['likes'] ?? 0} likes'),
          onTap: () {
            Navigator.of(context).push(
              CustomPageRoute(
                child: BlogDetailPage(
                  title: blogData['title'] ?? 'Untitled Blog',
                  content: blogData['content'] ?? 'No content available',
                  author: blogData['author'] ?? 'Unknown Author',
                  imageUrl: blogData['imageUrl'],
                  publishedDate: blogData['publishedDate'] ?? 'Unknown date',
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
