import 'dart:async';

import 'blog.dart';

class BlogRepository {
  // Static instance + private Constructor for simple Singleton-approach
  static BlogRepository instance = BlogRepository._privateConstructor();
  BlogRepository._privateConstructor();

  final _blogs = <Blog>[];

  int _nextId = 1;

  bool _isInitialized = false;

  void _initializeBlogs() async {
    addBlogPost(Blog(
      title: "Flutter ist toll!",
      content:
          "Mit Flutter hebst du deine App-Entwicklung auf ein neues Level. Probier es aus!",
      publishedAt: DateTime.now(),
    ));

    addBlogPost(Blog(
      title: "Der Kurs ist dabei abzuheben",
      content:
          "Fasten your seatbelts, we are ready for takeoff! Jetzt geht's ans Eingemachte. Bleib dabei!",
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
    ));

    addBlogPost(Blog(
      title: "Klasse erzeugt eine super App",
      content:
          "Während dem aktiven Plenum hat die Klasse alles rausgeholt und eine tolle App gebaut. Alle waren begeistert dabei und haben viel gelernt.",
      publishedAt: DateTime.now().subtract(const Duration(days: 2)),
    ));

    _isInitialized = true;
  }

  /// Returns all blog posts ordered by publishedAt descending.
  /// Simulates network delay.
  Future<List<Blog>> getBlogPosts() async {
    if (!_isInitialized) {
      _initializeBlogs();
    }

    await Future.delayed(const Duration(milliseconds: 500));

    return _blogs..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  /// Creates a new blog post and sets a new id.
  Future<void> addBlogPost(Blog blog) async {
    blog.id = _nextId++;
    _blogs.add(blog);
  }

  /// Deletes a blog post.
  Future<void> deleteBlogPost(Blog blog) async {
    _blogs.remove(blog);
  }

  /// Changes the like info of a blog post.
  Future<void> toggleLikeInfo(int blogId) async {
    final blog = _blogs.firstWhere((blog) => blog.id == blogId);
    blog.isLikedByMe = !blog.isLikedByMe;
  }

  /// Updates a blog post with the given id.
  Future<void> updateBlogPost(
      {required int blogId,
      required String title,
      required String content}) async {
    final blog = _blogs.firstWhere((blog) => blog.id == blogId);
    blog.title = title;
    blog.content = content;
  }
}
