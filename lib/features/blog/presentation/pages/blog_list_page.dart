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
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward(); // Start animation immediately
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
      body: StreamBuilder<List<BlogModel>>(
        stream: _blogRepository.fetchBlogs(),
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
          );
        },
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
