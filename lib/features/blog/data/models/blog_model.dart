class BlogModel {
  final String title;
  final String content;
  final String publishedDateString;
  final String imageUrl; // This field stores the image URL
  bool isLikedByMe;

  BlogModel({
    required this.title,
    required this.content,
    required this.publishedDateString,
    required this.imageUrl,
    this.isLikedByMe = false,
  });

  factory BlogModel.fromFirestore(Map<String, dynamic> data) {
    return BlogModel(
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      publishedDateString: data['publishedDateString'] ?? '',
      imageUrl: data['imageUrl'] ?? '', // Ensure the imageUrl is parsed
      isLikedByMe: data['isLikedByMe'] ?? false,
    );
  }
}
