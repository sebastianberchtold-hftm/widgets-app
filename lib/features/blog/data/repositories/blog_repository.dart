import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../models/blog_model.dart';

class BlogRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  static final BlogRepository _instance = BlogRepository._internal();
  BlogRepository._internal();
  static BlogRepository get instance => _instance;

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

  Future<void> addBlog({
    required String title,
    required String content,
    File? imageFile,
    required String userId,
  }) async {
    String? imageUrl;

    if (imageFile != null) {
      String imageName = DateTime.now().toString();
      Reference ref = _storage.ref().child('blog_images/$imageName');
      UploadTask uploadTask = ref.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;
      imageUrl = await snapshot.ref.getDownloadURL();
    }

    await _firestore.collection('blogs').add({
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'publishedDateString': DateTime.now().toIso8601String(),
      'uid': userId,
    });
  }
}
