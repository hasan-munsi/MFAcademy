import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/cadet.dart';
import 'package:mf_academy/model/program_preview.dart';

class CadetController {
  final List<Cadet> _cadets = [];

  List<Cadet> get cadets => _cadets;

  Future<List<Cadet>> getCadets(int type, int page) async {
    final List<Cadet> _tmp = [];
    final _response = await CustomHTTPRequests.cadetList(type, page);
    try {
      for (final data in _response["data"]) {
        _tmp.add(Cadet.fromJSON(data));
      }
    } catch (e) {
      Xarvis.logger.i(e);
    }
    return _tmp;
  }
}
