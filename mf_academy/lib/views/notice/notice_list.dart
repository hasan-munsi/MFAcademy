import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/notice_preview.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/notice_preview.dart';
import 'package:mf_academy/views/notice/notice_details.dart';
import 'package:mf_academy/views/result/result_details.dart';

class NoticeList extends StatefulWidget {
  static const String id = "/NoticeList";

  const NoticeList({Key? key}) : super(key: key);

  @override
  State<NoticeList> createState() => _ResultListState();
}

class _ResultListState extends State<NoticeList> {
  bool _init = true;
  int page = 1;
  bool _noMoreData = false;
  final NoticePreviewController _noticePreviewController =
  NoticePreviewController();
  final List<NoticePreview> _notices = [];

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    _scrollController.addListener(() {
      if (!_init && !_noMoreData) {
        if (_scrollController.position.pixels >
            _scrollController.position.maxScrollExtent - 200) {
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
      final List<NoticePreview> _tmp =
          await _noticePreviewController.getPrograms(page);
      if (_tmp.isEmpty) {
        _noMoreData = true;
      }
      _notices.addAll(_tmp);
      page++;
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
        title: Xarvis.genericText(
            text: "Notice List",
            textColor: Xarvis.appBgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init = true;
          page = 1;
          _noMoreData = false;
          _notices.clear();
          setState(() {});
          didChangeDependencies();
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ..._notices.map((e) => SingleNoticePreviewUI(noticePreview: e)),
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

class SingleNoticePreviewUI extends StatelessWidget {
  final NoticePreview noticePreview;

  const SingleNoticePreviewUI({Key? key, required this.noticePreview})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 10,
      child: Container(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Xarvis.genericText(
                text: noticePreview.title.capitalize??"", fontWeight: FontWeight.bold, maxLines: 2),
            Xarvis.genericText(
              text: noticePreview.description.capitalizeFirst??"",
              fontWeight: FontWeight.bold,
              maxLines: 3,
              fontSize: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Xarvis.genericText(
                    text: "Date: ${noticePreview.date}",
                    textColor: Xarvis.appBgColor),
                Xarvis.getGlobalButton(
                    action: () {
                      Get.to(() => NoticeDetails(noticeId: noticePreview.id));
                    },
                    height: 30,
                    child: Xarvis.genericText(
                        text: "Read more",
                        textColor: Xarvis.fair,
                        fontSize: 12))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
