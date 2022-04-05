import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/new_attendance.dart';
import 'package:mf_academy/controllers/student_controller.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/attendance.dart';
import 'package:mf_academy/model/student.dart';
import 'package:mf_academy/views/attendance/single_student_attendance.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

import '../../model/single_attendance.dart';

class AttendanceList extends StatefulWidget {
  static const String id = "/AttendanceList";

  const AttendanceList({Key? key}) : super(key: key);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  bool _init = true;

  final NewAttendanceController _attendanceController =
      NewAttendanceController();
  final List<SingleAttendance> _attendances = [];
  final List<String> _dates = [];

  @override
  void didChangeDependencies() async {
    if (_init) {
      await _attendanceController.loadAttendance();
      _attendances.addAll(_attendanceController.attendances);
      _dates.addAll(_attendanceController.getDates());
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
            text: "Attendance",
            textColor: Xarvis.appBgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: _dates.length,
          itemBuilder: (context, int i) => SingleDateAttendancesUI(
              label: _dates[i],
              attendances: _attendances
                  .where((element) => element.accessDate == _dates[i])
                  .toList()),
        ),
      ),
    );
  }
}

class SingleDateAttendancesUI extends StatelessWidget {
  final String label;
  final List<SingleAttendance> attendances;

  const SingleDateAttendancesUI(
      {Key? key, required this.label, required this.attendances})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Xarvis.appBgColor, width: 0.5)),
      child: ExpansionTile(
        collapsedBackgroundColor: Xarvis.appBgColor,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        collapsedIconColor: Xarvis.fair,
        iconColor: Xarvis.appBgColor,
        title: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Xarvis.appBgColor,
              borderRadius: BorderRadius.circular(5)),
          child: Xarvis.genericText(text: label, textColor: Xarvis.fair),
        ),
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: attendances
                  .map(
                    (e) => SingleAttendancePersonUI(attendance: e),
              ).toList(),
            ),
          )
        ],
      ),
    );
  }
}

class SingleAttendancePersonUI extends StatelessWidget {
  final SingleAttendance attendance;

  const SingleAttendancePersonUI({Key? key, required this.attendance})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(border: Border.all(color: Colors.blue), borderRadius:
      BorderRadius.circular(5)),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Xarvis.genericText(text: attendance.registrationId ?? "",
                fontWeight: FontWeight.bold, fontSize: 18),
                Xarvis.genericText(text: "ID# ${attendance.accessId ?? ""}"),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                  color: Colors.blue,
                    borderRadius: BorderRadius.circular(50)
                  ),
                  child: Xarvis.genericText(text: attendance.department??"",
                  textColor: Xarvis.fair),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 100,
            child: Column(
              children: [
                Xarvis.genericText(text: "Access Time", maxLines: 2),
                Xarvis.genericText(text: attendance.accessTime??"", maxLines: 2,
                fontWeight: FontWeight.bold),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
