import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/cadet.dart';
import 'package:mf_academy/controllers/program_preview.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/cadet.dart';
import 'package:mf_academy/model/program_preview.dart';
import 'package:mf_academy/views/cadet/cadet_details.dart';
import 'package:mf_academy/views/program/program_details.dart';

class CadetList extends StatefulWidget {
  final int type;
  final String title;
  const CadetList({Key? key, required this.type, this.title="Cadet List"}) : super(key: key);

  @override
  State<CadetList> createState() => _CadetListState();
}

class _CadetListState extends State<CadetList> {
  bool _init = true;
  int page = 1;
  bool _noMoreData = false;
  final CadetController _cadetController = CadetController();
  final List<Cadet> _cadets = [];

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
      final List<Cadet> _tmp =
          await _cadetController.getCadets(widget.type,page);
      if (_tmp.isEmpty) {
        _noMoreData = true;
      }
      _cadets.addAll(_tmp);
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
            text: widget.title,
            textColor: Xarvis.appBgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init = true;
          page = 1;
          _noMoreData = false;
          _cadets.clear();
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
                ..._cadets.map((e) => SingleCadetUI(cadet: e)),
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

class SingleCadetUI extends StatelessWidget {
  final Cadet cadet;

  const SingleCadetUI({Key? key, required this.cadet})
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
                text: cadet.title.capitalize??"", fontWeight: FontWeight.bold, maxLines: 2),
            Xarvis.genericText(
              text: cadet.description.capitalizeFirst??"",
              fontWeight: FontWeight.bold,
              maxLines: 3,
              fontSize: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Xarvis.genericText(
                    text: "Date: ${cadet.date}",
                    textColor: Xarvis.appBgColor),
                Xarvis.getGlobalButton(
                    action: () {
                      Get.to(() => CadetDetails(cadetId: cadet.id));
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
