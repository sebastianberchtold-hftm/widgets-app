import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_controls_demo/features/auth/page/sign_in_page.dart';
import 'package:ui_controls_demo/features/blog/data/models/blog_model.dart';
import 'package:ui_controls_demo/features/blog/data/repositories/blog_repository.dart';
import 'package:ui_controls_demo/features/blog/presentation/pages/add_blog_page.dart';
import 'package:ui_controls_demo/features/blog/presentation/widgets/slidable_blog_tile.dart';
import 'package:ui_controls_demo/features/blog/presentation/widgets/toggle_theme.dart';

class BlogListPage extends StatefulWidget {
  final Function(bool) toggleTheme;
  final bool isDarkMode;

  BlogListPage({required this.toggleTheme, required this.isDarkMode});

  @override
  _BlogListPageState createState() => _BlogListPageState();
}

class _BlogListPageState extends State<BlogListPage>
    with TickerProviderStateMixin {
  final BlogRepository _blogRepository = BlogRepository();
  List<BlogModel> _blogs = [];
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500), // Animation duration
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _refreshBlogs(); // Fetch blogs initially when the page loads
  }

  Future<void> _refreshBlogs() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Future.delayed(Duration(seconds: 3)); // Simulate loading delay
      List<BlogModel> fetchedBlogs = await _blogRepository.fetchBlogs().first;
      setState(() {
        _blogs = fetchedBlogs;
      });
      _controller.forward(); // Start the animation when blogs are loaded
    } catch (e) {
      print("Error fetching blogs: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to refresh blogs.')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog List'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              );
            },
          ),
          ThemeSwitcher(
            isDarkMode: widget.isDarkMode,
            onThemeChanged: widget.toggleTheme,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _refreshBlogs,
              child: _blogs.isEmpty
                  ? Center(child: Text('No blogs available.'))
                  : ListView.builder(
                      itemCount: _blogs.length,
                      itemBuilder: (context, index) {
                        BlogModel blog = _blogs[index];

                        // Apply fade animation to each blog tile
                        return FadeTransition(
                          opacity: _animation,
                          child: SlidableBlogTile(
                            blogId: blog.id,
                            blogData: {
                              'title': blog.title,
                              'content': blog.content,
                              'author': blog.author,
                              'publishedDate': blog.publishedDate,
                              'uid': blog.uid,
                              'likes': blog.likes,
                              'likedBy': blog.likedBy,
                            },
                          ),
                        );
                      },
                    ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    AddBlogPage(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  const begin = Offset(0.0, 1.0);
                  const end = Offset.zero;
                  const curve = Curves.ease;

                  var tween = Tween(begin: begin, end: end)
                      .chain(CurveTween(curve: curve));
                  var offsetAnimation = animation.drive(tween);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
              ),
            );
          },
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
