class BlogModel {
  int id;
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
      id: json['\$id'],
      title: json['title'],
      content: json['content'],
      publishedAt: DateTime.parse(json['publishedAt']),
    );
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
