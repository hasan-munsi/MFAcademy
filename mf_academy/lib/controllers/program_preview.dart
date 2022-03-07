import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/program_preview.dart';

class ProgramPreviewController {
  final List<ProgramPreview> _programs = [];

  List<ProgramPreview> get programs => _programs;

  Future<List<ProgramPreview>> getPrograms(int page) async {
    final List<ProgramPreview> _tmp = [];
    final _response = await CustomHTTPRequests.programList(page);
    try {
      for (final data in _response["data"]) {
        _tmp.add(ProgramPreview.fromJSON(data));
      }
    } catch (e) {
      Xarvis.logger.i(e);
    }
    return _tmp;
  }
}
