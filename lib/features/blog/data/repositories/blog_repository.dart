import 'dart:async';

import '../endpoints/blog_api.dart';
import '../models/blog_model.dart';

class BlogRepository {
  static BlogRepository instance = BlogRepository._privateConstructor();
  BlogRepository._privateConstructor();

  final BlogApi _api = BlogApi();

  Future<List<BlogModel>> getBlogPosts() async {
    return await _api.fetchBlogPosts();
  }

  Future<void> addBlogPost(BlogModel blog) async {
    await _api.createBlogPost(blog);
  }

  Future<void> deleteBlogPost(int id) async {
    await _api.deleteBlogPost(id);
  }

  Future<void> updateBlogPost(BlogModel blog) async {
    await _api.updateBlogPost(blog);
  }
}
