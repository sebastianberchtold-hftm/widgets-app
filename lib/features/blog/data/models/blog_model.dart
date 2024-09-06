class BlogModel {
  String id; // Blog's document ID
  final String title;
  final String content;
  final String author;
  final String publishedDate;
  final String? imageUrl; // Nullable imageUrl
  final String uid; // UID of the blog's owner

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.publishedDate,
    this.imageUrl, // imageUrl is optional
    required this.uid,
  });

  // Factory method to create a BlogModel from Firestore data
  factory BlogModel.fromFirestore(Map<String, dynamic> data, String docId) {
    return BlogModel(
      id: docId, // Pass the document ID from Firestore
      title: data['title'] ?? 'Untitled', // Fallback to 'Untitled' if null
      content: data['content'] ?? 'No content available', // Fallback if null
      author: data['author'] ?? 'Unknown', // Fallback if null
      publishedDate:
          data['publishedDate'] ?? 'Unknown date', // Fallback if null
      imageUrl: data['imageUrl'], // Nullable imageUrl
      uid: data['uid'] ?? '', // Fallback if UID is null
    );
  }
}
