class SingleNotification {
  final String id;
  final String title;
  final String date;
  final bool isRead;

  SingleNotification({
    required this.id,
    required this.title,
    required this.date,
    required this.isRead,
  });

  factory SingleNotification.fromJSON(dynamic data) {
    return SingleNotification(
      id: data["data"]["id"].toString(),
      title: data["data"]["title"],
      date: data["created_at"].toString().split("T")[0],
      isRead: data["read_at"] != null,
    );
  }
}
