import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/blog_model.dart';

class BlogRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Stream<List<BlogModel>> fetchBlogs() {
    try {
      return FirebaseFirestore.instance.collection('blogs').snapshots().map(
        (snapshot) {
          return snapshot.docs.map((doc) {
            return BlogModel.fromFirestore(
                doc.data() as Map<String, dynamic>, doc.id);
          }).toList();
        },
      );
    } catch (e) {
      throw Exception('Failed to stream blogs: $e');
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

  Future<void> addBlog(String title, String content, String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      DocumentReference blogRef =
          await FirebaseFirestore.instance.collection('blogs').add({
        'title': title,
        'content': content,
        'author': user.email ?? 'Anonymous',
        'publishedDate': DateTime.now().toString(),
        'likedBy': [],
        'likes': 0,
        'uid': user.uid,
        'imageUrl': imageUrl,
      });

      print("Blog added with ID: ${blogRef.id}");
    }
  }

  Future<void> updateBlog(String blogId, String title, String content) async {
    try {
      await _firestore.collection('blogs').doc(blogId).update({
        'title': title,
        'content': content,
        'updatedAt': DateTime.now().toString(),
      });
    } catch (e) {
      throw Exception('Failed to update blog: $e');
    }
  }

  Future<void> toggleLike(String blogId) async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      throw Exception('User is not authenticated');
    }

    DocumentSnapshot blogDoc =
        await _firestore.collection('blogs').doc(blogId).get();

    if (!blogDoc.exists) {
      throw Exception('Blog not found');
    }

    List<String> likedBy = List<String>.from(blogDoc['likedBy'] ?? []);

    if (likedBy.contains(currentUser.uid)) {
      await _firestore.collection('blogs').doc(blogId).update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([currentUser.uid]),
      });
    } else {
      await _firestore.collection('blogs').doc(blogId).update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([currentUser.uid]),
      });
    }
  }
}
