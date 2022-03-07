import 'package:mf_academy/model/student.dart';

class StudentController {
  final List<Student> _students = [];

  List<Student> get students => _students;

  loadStudents() {
    _students.addAll([
      Student(id: 0, name: "Arup K Bose", phone: "012854575362", image: "assets/images/logo.png", attendanceCount: 22),
      Student(id: 1, name: "Arup K Bose", phone: "012854575362", image: "assets/images/logo.png", attendanceCount: 25),
      Student(id: 2, name: "Arup K Bose", phone: "012854575362", image: "assets/images/logo.png", attendanceCount: 45),
      Student(id: 3, name: "Arup K Bose", phone: "012854575362", image: "assets/images/logo.png", attendanceCount: 37),
      Student(id: 4, name: "Arup K Bose", phone: "012854575362", image: "assets/images/logo.png", attendanceCount: 07),
      Student(id: 5, name: "Arup K Bose", phone: "012854575362", image: "assets/images/logo.png", attendanceCount: 13),
    ]);
  }
}
