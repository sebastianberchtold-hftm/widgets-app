import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/blog_model.dart';

class BlogApi {
  static const String baseUrl =
      'https://cloud.appwrite.io/v1/databases/blog-db/collections/blogs/documents';
  static const Map<String, String> headers = {
    'X-Appwrite-Project': '6568509f75ac404ff6ae',
    'X-Appwrite-Key':
        'ac0f362d0cf82fe3d138195e142c0a87a88cee4e2c48821192fb307e1a1c74ee694246f90082b4441aa98a2edaddead28ed6d18cf08c4de0df90dcaeeb53d14f14fb9eeb2edec6708c9553434f1d8df8f8acbfbefd35cccb70f2ab0f9a334dfd979b6052f6e8b8610d57465cbe8d71a7f65e8d48aede789eef6b976b1fe9b2e2',
    'Content-Type': 'application/json',
  };

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
      headers: headers,
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
      headers: headers,
      body: jsonEncode(blog.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update blog post');
    }
  }

  // Delete a blog post
  Future<void> deleteBlogPost(int id) async {
    final url = '$baseUrl/$id';
    final response = await http.delete(Uri.parse(url), headers: headers);
    if (response.statusCode != 204) {
      throw Exception('Failed to delete blog post');
    }
  }
}
