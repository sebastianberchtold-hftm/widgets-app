import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/blog_model.dart';

class BlogApi {
  static const String baseUrl = 'http://localhost:8081/api/blogs';

  // Fetch all blog posts
  Future<List<BlogModel>> fetchBlogPosts() async {
    final response = await http.get(Uri.parse(baseUrl), headers: headers);
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => BlogModel.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load blog posts');
    }
  }

  // Create a new blog post
  Future<BlogModel> createBlogPost(BlogModel blog) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(blog.toJson()),
    );
    if (response.statusCode == 201) {
      return BlogModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create blog post');
    }
  }

  // Update an existing blog post
  Future<void> updateBlogPost(BlogModel blog) async {
    final url = '$baseUrl/${blog.id}';
    final response = await http.put(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(blog.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update blog post');
    }
  }

  // Delete a blog post
  Future<void> deleteBlogPost(int id) async {
    final url = '$baseUrl/$id';
    final response = await http
        .delete(Uri.parse(url), headers: {'Content-Type': 'application/json'});

    if (response.statusCode != 204) {
      throw Exception('Failed to delete blog post');
    }
  }
}
