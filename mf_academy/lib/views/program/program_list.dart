import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/program_preview.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/program_preview.dart';
import 'package:mf_academy/views/program/program_details.dart';

class ProgramList extends StatefulWidget {
  static const String id = "/ProgramList";

  const ProgramList({Key? key}) : super(key: key);

  @override
  State<ProgramList> createState() => _ProgramListState();
}

class _ProgramListState extends State<ProgramList> {
  bool _init = true;
  int page = 1;
  bool _noMoreData = false;
  final ProgramPreviewController _programPreviewController =
      ProgramPreviewController();
  final List<ProgramPreview> _programs = [];

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
      final List<ProgramPreview> _tmp =
          await _programPreviewController.getPrograms(page);
      if (_tmp.isEmpty) {
        _noMoreData = true;
      }
      _programs.addAll(_tmp);
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
            text: "Program List",
            textColor: Xarvis.appBgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _init = true;
          page = 1;
          _noMoreData = false;
          _programs.clear();
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
                ..._programs.map((e) => SingleProgramPreviewUI(program: e)),
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

class SingleProgramPreviewUI extends StatelessWidget {
  final ProgramPreview program;

  const SingleProgramPreviewUI({Key? key, required this.program})
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
                text: program.title.capitalize??"", fontWeight: FontWeight.bold, maxLines: 2),
            Xarvis.genericText(
              text: program.description.capitalizeFirst??"",
              fontWeight: FontWeight.bold,
              maxLines: 3,
              fontSize: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Xarvis.genericText(
                    text: "Date: ${program.date}",
                    textColor: Xarvis.appBgColor),
                Xarvis.getGlobalButton(
                    action: () {
                      Get.to(() => ProgramDetails(programId: program.id));
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
