import 'package:flutter/material.dart';

import 'blog.dart';
import 'blog_repository.dart';

void main() {
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlogListPage(),
    );
  }
}

class BlogListPage extends StatefulWidget {
  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage> {
  late Future<List<Blog>> _blogsFuture;

  @override
  void initState() {
    super.initState();
    _blogsFuture = BlogRepository.instance.getBlogPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog List'),
      ),
      body: FutureBuilder<List<Blog>>(
        future: _blogsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No blogs available.'));
          }

          List<Blog> blogs = snapshot.data!;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              Blog blog = blogs[index];
              return BlogTile(blog: blog);
            },
          );
        },
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final Blog blog;

  const BlogTile({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(blog.title),
      subtitle: Text('Published on ${blog.publishedDateString}'),
      onTap: () => _navigateToBlogDetail(context, blog),
    );
  }

  void _navigateToBlogDetail(BuildContext context, Blog blog) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlogDetailPage(blog: blog)),
    );
  }
}

class BlogDetailPage extends StatefulWidget {
  final Blog blog;

  const BlogDetailPage({Key? key, required this.blog}) : super(key: key);

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog.title),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.blog.title,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Published on ${widget.blog.publishedDateString}'),
            SizedBox(height: 16),
            Text(widget.blog.content, style: TextStyle(fontSize: 16)),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  widget.blog.isLikedByMe = !widget.blog.isLikedByMe;
                });
              },
              child: Text(widget.blog.isLikedByMe ? 'Unlike' : 'Like'),
            ),
          ],
        ),
      ),
    );
  }
}
