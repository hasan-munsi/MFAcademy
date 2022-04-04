class CadetDocPreview {
  final int id;
  final String title;
  final String description;
  final String date;

  CadetDocPreview({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory CadetDocPreview.fromJSON(dynamic data) {
    return CadetDocPreview(
      id: data["id"],
      title: data["title"]??"",
      description: data["description"]??"",
      date: data["publish_at"]??"",
    );
  }
}
