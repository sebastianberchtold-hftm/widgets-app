class BlogModel {
  final String id;
  final String title;
  final String content;
  final String author;
  final String publishedDate;
  final String uid;
  final String imageUrl;
  final int likes;
  final List<String> likedBy;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.publishedDate,
    required this.uid,
    required this.imageUrl,
    required this.likes,
    required this.likedBy,
  });

  factory BlogModel.fromFirestore(Map<String, dynamic> data, String id) {
    return BlogModel(
      id: id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      author: data['author'] ?? '',
      publishedDate: data['publishedDate'] ?? '',
      uid: data['uid'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      likes: data['likes'] ?? 0,
      likedBy: List<String>.from(data['likedBy'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'content': content,
      'author': author,
      'publishedDate': publishedDate,
      'uid': uid,
      'imageUrl': imageUrl,
      'likes': likes,
      'likedBy': likedBy,
    };
  }
}
