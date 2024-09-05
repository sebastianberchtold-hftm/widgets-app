import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/blog_model.dart';

class BlogRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BlogModel>> fetchBlogs() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('blogs').get();
      List<BlogModel> blogs = querySnapshot.docs.map((doc) {
        return BlogModel.fromFirestore(doc.data() as Map<String, dynamic>);
      }).toList();
      return blogs;
    } catch (e) {
      throw Exception('Failed to load blogs: $e');
    }
  }
}
