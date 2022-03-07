import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/notification.dart';

class NotificationController {
  final List<SingleNotification> _notifications = [];

  List<SingleNotification> get notifications => _notifications;

  Future<List<SingleNotification>> loadNotifications(int page) async {
    final List<SingleNotification> _tmp = [];
    final _response = await CustomHTTPRequests.notificationList(page);
    if (_response["data"].isNotEmpty) {
      for (final data in _response["data"]["data"]) {
        _tmp.add(SingleNotification.fromJSON(data));
      }
    }
    return _tmp;
  }
}
