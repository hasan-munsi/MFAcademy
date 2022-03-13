class NoticePreview {
  final int id;
  final String title;
  final String description;
  final String date;

  NoticePreview({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory NoticePreview.fromJSON(dynamic data) {
    return NoticePreview(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      date: data["publish_at"],
    );
  }
}
