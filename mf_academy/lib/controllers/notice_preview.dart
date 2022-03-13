import 'package:mf_academy/globals/xarvis.dart';
import 'package:mf_academy/http/custom_http_requests.dart';
import 'package:mf_academy/model/notice_preview.dart';
import 'package:mf_academy/model/notice_preview.dart';
import 'package:mf_academy/model/notice_preview.dart';
import 'package:mf_academy/model/notice_preview.dart';
import 'package:mf_academy/model/notice_preview.dart';
import 'package:mf_academy/model/program_preview.dart';
import 'package:mf_academy/model/result_preview.dart';

class NoticePreviewController {
  final List<NoticePreview> _notices = [];

  List<NoticePreview> get notices => _notices;

  Future<List<NoticePreview>> getPrograms(int page) async {
    final List<NoticePreview> _tmp = [];
    final _response = await CustomHTTPRequests.noticeList(page);
    try {
      for (final data in _response["data"]) {
        _tmp.add(NoticePreview.fromJSON(data));
      }
    } catch (e) {
      Xarvis.logger.i(e);
    }
    return _tmp;
  }
}
