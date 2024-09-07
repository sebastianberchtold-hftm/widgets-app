import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BlogDetailPage extends StatefulWidget {
  final String title;
  final String content;
  final String author;
  final String? imageUrl;
  final String publishedDate;
  final String blogId;

  const BlogDetailPage({
    Key? key,
    required this.title,
    required this.content,
    required this.author,
    this.imageUrl,
    required this.publishedDate,
    required this.blogId,
  }) : super(key: key);

  @override
  _BlogDetailPageState createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends State<BlogDetailPage> {
  int likes = 0;
  bool isLiked = false;
  final User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _fetchLikesAndCheckIfLiked();
  }

  Future<void> _fetchLikesAndCheckIfLiked() async {
    DocumentSnapshot blogSnapshot = await FirebaseFirestore.instance
        .collection('blogs')
        .doc(widget.blogId)
        .get();

    if (blogSnapshot.exists) {
      setState(() {
        likes = blogSnapshot['likes'] ?? 0;
        List likedBy = blogSnapshot['likedBy'] ?? [];
        isLiked = likedBy.contains(currentUser?.uid);
      });
    }
  }

  Future<void> _toggleLike() async {
    if (currentUser == null) return;

    DocumentReference blogRef =
        FirebaseFirestore.instance.collection('blogs').doc(widget.blogId);

    if (isLiked) {
      await blogRef.update({
        'likes': FieldValue.increment(-1),
        'likedBy': FieldValue.arrayRemove([currentUser!.uid]),
      });
    } else {
      await blogRef.update({
        'likes': FieldValue.increment(1),
        'likedBy': FieldValue.arrayUnion([currentUser!.uid]),
      });
    }

    setState(() {
      isLiked = !isLiked;
      likes = isLiked ? likes + 1 : likes - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.imageUrl != null && widget.imageUrl!.isNotEmpty
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        widget.imageUrl!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )
                  : const Icon(Icons.image, size: 100),
              const SizedBox(height: 20),
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'By ${widget.author}',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'Published on ${widget.publishedDate}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              Text(
                widget.content,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _toggleLike,
                child: Row(
                  children: [
                    Icon(
                      isLiked ? Icons.favorite : Icons.favorite_border,
                      color: isLiked ? Colors.red : Colors.grey,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$likes likes',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
