import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ui_controls_demo/features/blog/presentation/pages/blog_tile.dart';
import 'package:ui_controls_demo/features/blog/presentation/widgets/slidable_actions.dart';

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
    bool isOwner = currentUser != null && currentUser.uid == blogData['uid'];

    return GestureDetector(
      onDoubleTap: () async {
        try {
          DocumentSnapshot blogSnapshot = await FirebaseFirestore.instance
              .collection('blogs')
              .doc(blogId)
              .get();

          if (blogSnapshot.exists) {
            List likedBy = blogSnapshot['likedBy'] ?? [];
            bool isLiked =
                likedBy.contains(FirebaseAuth.instance.currentUser?.uid);

            await blogRepository.toggleLike(blogId);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text(isLiked ? 'Unliked the blog!' : 'Liked the blog!')),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(e.toString())),
          );
        }
      },
      child: isOwner ? _buildSlidableOwner(context) : _buildBlogTile(context),
    );
  }

  Widget _buildSlidableOwner(BuildContext context) {
    return Slidable(
      key: ValueKey(blogId),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableActions(blogId: blogId),
        ],
      ),
      child: _buildBlogTile(context),
    );
  }

  Widget _buildBlogTile(BuildContext context) {
    return BlogTile(
      imageUrl: blogData['imageUrl'] ?? '',
      title: blogData['title'] ?? 'Untitled Blog',
      author: blogData['author'] ?? 'Unknown Author',
      likes: blogData['likes'] ?? 0,
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => BlogDetailPage(
              blogId: blogData['id'] ?? '0',
              title: blogData['title'] ?? 'Untitled Blog',
              content: blogData['content'] ?? 'No content available',
              author: blogData['author'] ?? 'Unknown Author',
              imageUrl: blogData['imageUrl'],
              publishedDate: blogData['publishedDate'] ?? 'Unknown date',
            ),
          ),
        );
      },
    );
  }
}
