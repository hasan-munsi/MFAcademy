import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/single_attendance.dart';

class NewAttendanceController{
  final List<SingleAttendance> _attendances = [];

  List<SingleAttendance> get attendances=>_attendances;

  Future loadAttendance()async{
    final _response = await CustomHTTPRequests.loadAttendanceInfo();
    if(_response!=false){
      for(final attendance in _response){
        _attendances.add(SingleAttendance.fromJson(attendance));
      }
    }
  }

  List<String> getDates(){
    List<String> _dates = [];
    for(final attendance in _attendances){
      if(attendance.accessDate!=null){
        _dates.add(attendance.accessDate!);
      }
    }
    _dates.sort((a,b){
      DateTime _firstDate = Xarvis.getStringToDateTime1(a);
      DateTime _secondDate = Xarvis.getStringToDateTime1(b);
      return _firstDate.difference(_secondDate).inDays;
    });
    return _dates.toSet().toList();
  }

}