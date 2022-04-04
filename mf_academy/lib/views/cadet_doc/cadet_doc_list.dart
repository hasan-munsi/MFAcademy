import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/cadet_doc_preview.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/views/result/result_details.dart';

import '../../model/cadet_doc_preview.dart';

class CadetDocList extends StatefulWidget {
  static const String id = "/CadetDocList";

  const CadetDocList({Key? key}) : super(key: key);

  @override
  State<CadetDocList> createState() => _CadetDocListState();
}

class _CadetDocListState extends State<CadetDocList> {
  bool _init = true;
  int page = 1;
  bool _noMoreData = false;
  final CadetDocPreviewController _cadetDocPreviewController =
  CadetDocPreviewController();
  final List<CadetDocPreview> _docs = [];

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
      final List<CadetDocPreview> _tmp =
          await _cadetDocPreviewController.getDocs(page);
      if (_tmp.isEmpty) {
        _noMoreData = true;
      }
      _docs.addAll(_tmp);
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
            text: "Cadet Doc List",
            textColor: Xarvis.appBgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init = true;
          page = 1;
          _noMoreData = false;
          _docs.clear();
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
                ..._docs.map((e) => SingleCadetDocPreviewUI(cadetDocPreview: e)),
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

class SingleCadetDocPreviewUI extends StatelessWidget {
  final CadetDocPreview cadetDocPreview;

  const SingleCadetDocPreviewUI({Key? key, required this.cadetDocPreview})
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
                text: cadetDocPreview.title.capitalize??"", fontWeight: FontWeight.bold, maxLines: 2),
            Xarvis.genericText(
              text: cadetDocPreview.description.capitalizeFirst??"",
              fontWeight: FontWeight.bold,
              maxLines: 3,
              fontSize: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Xarvis.genericText(
                    text: "Date: ${cadetDocPreview.date}",
                    textColor: Xarvis.appBgColor),
                Xarvis.getGlobalButton(
                    action: () {
                      Get.to(() => ResultDetails(resultId: cadetDocPreview.id));
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
