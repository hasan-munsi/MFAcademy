class ProgramPreview {
  final int id;
  final String title;
  final String description;
  final String date;

  ProgramPreview({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
  });

  factory ProgramPreview.fromJSON(dynamic data) {
    return ProgramPreview(
      id: data["id"]??0,
      title: data["program_name"]??"",
      description: data["program_description"]??"",
      date: data["publish_at"]??"",
    );
  }
}
