import 'dart:async';

import 'blog.dart';
import 'blog_api.dart';

class BlogRepository {
  static BlogRepository instance = BlogRepository._privateConstructor();
  BlogRepository._privateConstructor();

  final BlogApi _api = BlogApi();

  Future<List<Blog>> getBlogPosts() async {
    return await _api.fetchBlogPosts();
  }

  Future<void> addBlogPost(Blog blog) async {
    await _api.createBlogPost(blog);
  }

  Future<void> deleteBlogPost(int id) async {
    await _api.deleteBlogPost(id);
  }

  Future<void> updateBlogPost(Blog blog) async {
    await _api.updateBlogPost(blog);
  }
}
