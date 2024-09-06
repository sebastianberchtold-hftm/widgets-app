import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ui_controls_demo/features/auth/page/sign_in_page.dart';
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

class _BlogListPageState extends State<BlogListPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // If the user is not authenticated, navigate to the sign-in page
        if (!snapshot.hasData) {
          Future.microtask(() => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SignInPage()),
              ));
          return SizedBox(); // Empty widget while redirecting
        }

        // If the user is authenticated, show the blog list page
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
          body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return Center(child: Text('No blogs available.'));
              }

              List<QueryDocumentSnapshot> blogs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: blogs.length,
                itemBuilder: (context, index) {
                  var blogData = blogs[index].data() as Map<String, dynamic>;
                  String blogId = blogs[index].id;

                  return SlidableBlogTile(blogId: blogId, blogData: blogData);
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
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
        );
      },
    );
  }
}
