import 'package:flutter/material.dart';

import '../features/blog/data/models/blog_model.dart';
import '../features/blog/data/repositories/blog_repository.dart';
import '../features/blog/presentation/pages/edit_blog_page.dart';

void main() {
  runApp(BlogApp());
}

class BlogApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BlogModel List',
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
  late Future<List<BlogModel>> _blogsFuture;

  @override
  void initState() {
    super.initState();
    _blogsFuture = BlogRepository.instance.getBlogPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BlogModel List'),
      ),
      body: FutureBuilder<List<BlogModel>>(
        future: _blogsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No blogs available.'));
          }

          List<BlogModel> blogs = snapshot.data!;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              BlogModel blog = blogs[index];
              return BlogTile(blog: blog);
            },
          );
        },
      ),
    );
  }
}

class BlogTile extends StatelessWidget {
  final BlogModel blog;

  const BlogTile({Key? key, required this.blog}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(blog.title),
      subtitle: Text('Published on ${blog.publishedDateString}'),
      onTap: () => _navigateToBlogDetail(context, blog),
    );
  }

  void _navigateToBlogDetail(BuildContext context, BlogModel blog) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BlogDetailPage(blog: blog)),
    );
  }
}

class BlogDetailPage extends StatefulWidget {
  final BlogModel blog;

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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              _navigateToEditBlogPage(context, widget.blog);
            },
          ),
        ],
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

  void _navigateToEditBlogPage(BuildContext context, BlogModel blog) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditBlogPage(blog: blog)),
    ).then((_) {
      // Optional: update the state to reflect any changes after editing.
      setState(() {});
    });
  }
}
