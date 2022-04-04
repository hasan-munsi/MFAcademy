class ResultPreview {
  final int id;
  final String title;
  final String description;
  final String date;

  ResultPreview({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory ResultPreview.fromJSON(dynamic data) {
    return ResultPreview(
      id: data["id"],
      title: data["title"]??"",
      description: data["description"]??"",
      date: data["publish_at"]??"",
    );
  }
}
