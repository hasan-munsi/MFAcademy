import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/notification.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/notification.dart';
import 'package:mf_academy/views/notifications/notifications_details.dart';

class NotificationsList extends StatefulWidget {
  static const String id = "/NotificationsList";

  const NotificationsList({Key? key}) : super(key: key);

  @override
  State<NotificationsList> createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  bool _init = true;
  int page = 1;
  bool _noMoreData = false;

  final NotificationController _notificationController = NotificationController();
  final List<SingleNotification> _notifications = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (!_init && !_noMoreData) {
        if (_scrollController.position.pixels > _scrollController.position.maxScrollExtent - 200) {
          setState(() {
            _init = true;
          });
          didChangeDependencies();
        }
      }
    });
    super.initState();
  }

  @override
  void didChangeDependencies() async {
    if (_init) {
      final List<SingleNotification> _tmp = await _notificationController.loadNotifications(page);
      _notifications.addAll(_tmp);
      page++;
      if (_tmp.isEmpty) {
        _noMoreData = true;
      }
      if (mounted) {
        setState(() {
          _init = false;
        });
      }
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Xarvis.genericText(text: "Notifications", textColor: Xarvis.appBgColor, fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 20),
              child: InkWell(
                onTap: () async {
                  await CustomHTTPRequests.readAllNotification();
                },
                child: Xarvis.genericText(text: "Read All", textColor: Colors.blue, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: RefreshIndicator(
          onRefresh: () async{
            _init = true;
            page = 1;
            _noMoreData = false;
            _notifications.clear();
            setState(() {});
            didChangeDependencies();
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ..._notifications.map(
                  (e) => InkWell(
                    onTap: () {
                      Get.to(() => NotificationDetails(
                            id: e.id,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Xarvis.genericText(text: e.title, maxLines: 2, fontWeight: e.isRead ? FontWeight.normal : FontWeight.bold),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Xarvis.genericText(text: "Date: ${e.date}", textColor: Xarvis.appBgColor, fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                ),
                if (_init)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: CircularProgressIndicator(
                          color: Xarvis.appBgColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
