class Cadet {
  final int id;
  final String title;
  final String description;
  final String date;

  Cadet({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory Cadet.fromJSON(dynamic data) {
    return Cadet(
      id: data["id"],
      title: data["title"],
      description: data["description"],
      date: data["publish_at"],
    );
  }
}
