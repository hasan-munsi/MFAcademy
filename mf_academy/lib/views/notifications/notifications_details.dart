import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';

import '../utils/pdf_viewer.dart';

class NotificationDetails extends StatefulWidget {
  final String id;
  const NotificationDetails({Key? key, required this.id}) : super(key: key);

  @override
  State<NotificationDetails> createState() => _NotificationDetailsState();
}

class _NotificationDetailsState extends State<NotificationDetails> {
  bool _init = true;

  dynamic _data;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _data = await CustomHTTPRequests.notificationDetails(widget.id);
      _data = _data["data"];
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
        title: Xarvis.genericText(text: "Notification Details", textColor: Xarvis.appBgColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: Card(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Xarvis.genericText(text: _data?["title"] ?? "", fontSize: 20, fontWeight: FontWeight.bold, maxLines: 5),
                  Xarvis.genericText(text: "Date: ${_data?["sent_at"].toString().split("T")[0]}", textColor: Colors.blue),
                  Xarvis.genericText(text: _data?["body"] ?? "", maxLines: 50),
                  if(_data?["attachment"]?["file_path"]!=null)
                  Xarvis.getGlobalButton(
                      action: () {
                        Get.to(() => GlobalPdfViewer(url: _data?["attachment"]["file_path"] ?? ""));
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(child: Xarvis.genericText(text: "Show PDF", textColor: Xarvis.fair)),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
