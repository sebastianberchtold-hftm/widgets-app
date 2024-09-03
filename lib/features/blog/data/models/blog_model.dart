class BlogModel {
  String id;
  String title;
  String content;
  DateTime publishedAt;
  bool isLikedByMe = false;

  BlogModel({
    required this.id,
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";

  factory BlogModel.fromJson(Map<String, dynamic> json) {
    return BlogModel(
        id: json['\$id'] ?? '', // Default to an empty string if null
        title: json['title'] ?? 'Untitled', // Default to 'Untitled' if null
        content: json['content'] ?? 'No content available', // Default content
        publishedAt: DateTime.parse(
            json['publishedAt'] ?? DateTime.now().toIso8601String()));
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'publishedAt': publishedAt.toIso8601String(),
      'isLikedByMe': isLikedByMe,
    };
  }
}
