import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/views/utils/pdf_viewer.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class ResultDetails extends StatefulWidget {
  final int resultId;
  const ResultDetails({Key? key, required this.resultId}) : super(key: key);

  @override
  State<ResultDetails> createState() => _ResultDetailsState();
}

class _ResultDetailsState extends State<ResultDetails> {
  bool _init = true;

  dynamic _data;

  @override
  void didChangeDependencies() async {
    if (_init) {
      _data = await CustomHTTPRequests.resultDetails(widget.resultId);
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
    return ModalProgressHUD(
      inAsyncCall: _init,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Xarvis.genericText(text: "Result Details", textColor: Xarvis.appBgColor, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        body: Container(
          padding: const EdgeInsets.all(10),
          child: Card(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Xarvis.genericText(text: _data?["title"] ?? "", fontSize: 20, fontWeight: FontWeight.bold, maxLines: 5),
                    Xarvis.genericText(text: _data?["publish_at"] ?? "", textColor: Colors.blue),
                    Xarvis.genericText(text: _data?["description"] ?? "", maxLines: 500),
                    Xarvis.getGlobalButton(
                        action: () {
                          Get.to(() => GlobalPdfViewer(url: _data?["attachment"]["file_path"] ?? ""));
                        },
                        height: 35,
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
      ),
    );
  }
}
