import 'package:mf_academy/model/attendance.dart';

class AttendanceController {
  final List<Attendance> _attendances = [];

  List<Attendance> get attendances => _attendances;

  loadAttendance() {
    _attendances.addAll([
      Attendance(id: 0, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 1, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 2, date: "22nd Dec, 2022", day: "Tuesday", isPresent: false),
      Attendance(id: 3, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 4, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 5, date: "22nd Dec, 2022", day: "Tuesday", isPresent: false),
      Attendance(id: 6, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 7, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 8, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 9, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 10, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 11, date: "22nd Dec, 2022", day: "Tuesday", isPresent: false),
      Attendance(id: 12, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 13, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
      Attendance(id: 14, date: "22nd Dec, 2022", day: "Tuesday", isPresent: true),
    ]);
  }
}
