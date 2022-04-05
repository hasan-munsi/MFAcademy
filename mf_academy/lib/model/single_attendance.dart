import 'package:mf_academy/globals/xarvis.dart';

class SingleAttendance {
  String? unitName;
  String? registrationId;
  String? accessId;
  String? department;
  String? accessTime;
  String? accessDate;
  String? userName;
  String? unitId;
  String? card;

  SingleAttendance(
      {this.unitName,
        this.registrationId,
        this.accessId,
        this.department,
        this.accessTime,
        this.accessDate,
        this.userName,
        this.unitId,
        this.card});

  SingleAttendance.fromJson(Map<String, dynamic> json) {
    unitName = json['unit_name'];
    registrationId = json['registration_id'];
    accessId = json['access_id'];
    department = json['department'];
    accessTime = Xarvis.getStringToStringTime1(json['access_time']);
    accessDate = Xarvis.getStringToStringDate1(json['access_date']);
    userName = json['user_name'];
    unitId = json['unit_id'];
    card = json['card'];
  }
}