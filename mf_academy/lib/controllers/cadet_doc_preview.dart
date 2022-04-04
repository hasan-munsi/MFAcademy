import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/cadet_doc_preview.dart';
import 'package:mf_academy/model/cadet_doc_preview.dart';
import 'package:mf_academy/model/cadet_doc_preview.dart';
import 'package:mf_academy/model/cadet_doc_preview.dart';
import 'package:mf_academy/model/cadet_doc_preview.dart';
import 'package:mf_academy/model/program_preview.dart';
import 'package:mf_academy/model/result_preview.dart';

class CadetDocPreviewController {
  final List<CadetDocPreview> _docs = [];

  List<CadetDocPreview> get docs => _docs;

  Future<List<CadetDocPreview>> getDocs(int page) async {
    final List<CadetDocPreview> _tmp = [];
    final _response = await CustomHTTPRequests.docList(page);
    try {
      for (final data in _response["data"]) {
        _tmp.add(CadetDocPreview.fromJSON(data));
      }
    } catch (e) {
      Xarvis.logger.i(e);
    }
    return _tmp;
  }
}
