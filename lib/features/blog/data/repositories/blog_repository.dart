import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/blog_model.dart';

class BlogRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BlogModel>> fetchBlogs() async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('blogs').get();
      return querySnapshot.docs.map((doc) {
        return BlogModel.fromFirestore(
            doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }

  Future<void> deleteBlog(String blogId, String blogOwnerUid) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null && currentUser.uid == blogOwnerUid) {
      try {
        await _firestore.collection('blogs').doc(blogId).delete();
      } catch (e) {
        throw Exception('Failed to delete blog: $e');
      }
    } else {
      throw Exception('You do not have permission to delete this blog');
    }
  }

  Future<void> addBlog(String title, String content) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      await FirebaseFirestore.instance.collection('blogs').add({
        'title': title,
        'content': content,
        'author': user.displayName ?? 'Anonymous',
        'publishedDate': DateTime.now().toString(),
        'uid': user.uid,
      });
    }
  }

  Future<void> updateBlog(String blogId, String title, String content) async {
    try {
      await _firestore.collection('blogs').doc(blogId).update({
        'title': title,
        'content': content,
        'updatedAt':
            DateTime.now().toString(), // Optionally update the timestamp
      });
    } catch (e) {
      throw Exception('Failed to update blog: $e');
    }
  }
}
