import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/program_preview.dart';
import 'package:mf_academy/model/result_preview.dart';

class ResultPreviewController {
  final List<ResultPreview> _results = [];

  List<ResultPreview> get programs => _results;

  Future<List<ResultPreview>> getPrograms(int page) async {
    final List<ResultPreview> _tmp = [];
    final _response = await CustomHTTPRequests.resultList(page);
    try {
      for (final data in _response["data"]) {
        _tmp.add(ResultPreview.fromJSON(data));
      }
    } catch (e) {
      Xarvis.logger.i(e);
    }
    return _tmp;
  }
}
