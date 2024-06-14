class Blog {
  int id;
  String title;
  String content;
  DateTime publishedAt;
  bool isLikedByMe = false;

  Blog({
    this.id = 0,
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  String get publishedDateString =>
      "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";
}
