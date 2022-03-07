class User {
  int? id;
  String? name;
  String? rollNo;
  String? regNo;
  String? fatherName;
  String? motherName;
  String? phoneNo;
  String? fatherPhnNo;
  String? address;
  String? email;
  String? password;
  int? status;
  int? role;

  User({this.id, this.name, this.rollNo, this.regNo, this.fatherName, this.motherName, this.phoneNo, this.fatherPhnNo, this.address, this.email, this.password, this.status, this.role});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rollNo = json['roll_no'];
    regNo = json['reg_no'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    phoneNo = json['phone_no'];
    fatherPhnNo = json['father_phn_no'];
    address = json['address'];
    email = json['email'];
    password = json['password'];
    status = json['status'];
    role = json['role'];
  }
}
