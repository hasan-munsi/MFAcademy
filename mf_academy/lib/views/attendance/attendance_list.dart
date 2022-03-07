import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mf_academy/controllers/student_controller.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/model/student.dart';
import 'package:mf_academy/views/attendance/single_student_attendance.dart';

class AttendanceList extends StatefulWidget {
  static const String id = "/AttendanceList";

  const AttendanceList({Key? key}) : super(key: key);

  @override
  State<AttendanceList> createState() => _AttendanceListState();
}

class _AttendanceListState extends State<AttendanceList> {
  bool _init = true;

  final StudentController _studentController = StudentController();
  final List<Student> _students = [];

  @override
  void didChangeDependencies() {
    if (_init) {
      _studentController.loadStudents();
      _students.addAll(_studentController.students);
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
        title: Xarvis.genericText(text: "Attendance", textColor: Xarvis.appBgColor, fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            onPressed: () {},
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Xarvis.genericText(text: "March 2022", textColor: Xarvis.appBgColor, fontWeight: FontWeight.bold, fontSize: 20),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: _students.length,
                itemBuilder: (context, int i) => InkWell(
                  onTap: () {
                    Get.toNamed(SingleStudentAttendance.id);
                  },
                  child: Card(
                    elevation: 5,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Image.asset(
                            _students[i].image,
                            width: 50,
                            height: 50,
                          ),
                          Xarvis.customWidth(10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Xarvis.genericText(text: _students[i].name, fontWeight: FontWeight.bold),
                                Xarvis.genericText(text: _students[i].phone),
                              ],
                            ),
                          ),
                          Xarvis.customWidth(10),
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(5)),
                            child: Xarvis.genericText(text: _students[i].attendanceCount.toString(), textColor: Xarvis.fair),
                          ),
                        ],
                      ),
                    ),
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
