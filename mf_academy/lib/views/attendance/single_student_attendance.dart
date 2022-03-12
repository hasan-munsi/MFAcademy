import 'package:flutter/material.dart';
import 'package:mf_academy/controllers/attendance.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/attendance.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class SingleStudentAttendance extends StatefulWidget {
  static const String id = "/SingleStudentAttendance";

  const SingleStudentAttendance({Key? key}) : super(key: key);

  @override
  State<SingleStudentAttendance> createState() =>
      _SingleStudentAttendanceState();
}

class _SingleStudentAttendanceState extends State<SingleStudentAttendance> {
  bool _init = true;

  final AttendanceController _attendanceController = AttendanceController();
  final List<Attendance> _attendances = [];

  @override
  void didChangeDependencies() {
    if (_init) {
      _attendanceController.loadAttendance();
      _attendances.addAll(_attendanceController.attendances);
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
            text: "Attendance Details",
            textColor: Xarvis.appBgColor,
            fontSize: 20,
            fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            onPressed: () async {
              await showMonthPicker(
                context: context,
                firstDate: DateTime(2000),
                lastDate: DateTime.now(),
                initialDate: DateTime.now(),
              );
            },
            icon: const Icon(
              Icons.calendar_today_outlined,
              color: Xarvis.dark,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Xarvis.genericText(
                text: "Arup K Bose",
                textColor: Xarvis.appBgColor,
                fontWeight: FontWeight.bold,
                fontSize: 24),
            Xarvis.genericText(
                text: "March 2022",
                textColor: Xarvis.dark,
                fontWeight: FontWeight.bold,
                fontSize: 20),
            Expanded(
              child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: _attendances.length,
                separatorBuilder: (_, __) => const Divider(
                  height: 1,
                ),
                itemBuilder: (context, int i) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: _attendances[i].isPresent
                          ? Colors.blue.withOpacity(0.5)
                          : Xarvis.appBgColor.withOpacity(0.5)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Xarvis.genericText(text: _attendances[i].date),
                      Xarvis.genericText(text: _attendances[i].day),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: _attendances[i].isPresent
                                ? Colors.blue
                                : Xarvis.appBgColor),
                        child: Xarvis.genericText(
                            text: _attendances[i].isPresent
                                ? "Present"
                                : "Absent",
                            textColor: Xarvis.fair),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
