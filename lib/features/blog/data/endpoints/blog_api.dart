import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/blog_model.dart';

class BlogApi {
  static final BlogApi _instance = BlogApi._privateConstructor();
  BlogApi._privateConstructor();

  factory BlogApi() {
    return _instance;
  }

  static BlogApi get instance => _instance;

  static const String baseUrl =
      "http://localhost:8081/blogs"; // Replace with your backend URL

  Future<List<BlogModel>> getBlogs() async {
    final response = await http.get(Uri.parse(baseUrl));

    if (response.statusCode == 200) {
      List<dynamic> json = jsonDecode(response.body);
      return json.map((blog) => BlogModel.fromJson(blog)).toList();
    } else {
      throw Exception('Failed to load blogs');
    }
  }

  Future<BlogModel> getBlog(String blogId) async {
    final response = await http.get(Uri.parse('$baseUrl/$blogId'));

    if (response.statusCode == 200) {
      return BlogModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load blog');
    }
  }

  Future<void> createBlog(BlogModel blog) async {
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(blog.toJson()),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create blog');
    }
  }

  Future<void> updateBlog(String blogId, BlogModel blog) async {
    final response = await http.put(
      Uri.parse('$baseUrl/$blogId'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(blog.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update blog');
    }
  }

  Future<void> deleteBlog(String blogId) async {
    final response = await http.delete(Uri.parse('$baseUrl/$blogId'));

    if (response.statusCode != 204) {
      throw Exception('Failed to delete blog');
    }
  }
}
