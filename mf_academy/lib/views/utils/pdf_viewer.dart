import 'package:flutter/material.dart';
import 'package:mf_academy/globals/xarvis.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class GlobalPdfViewer extends StatefulWidget {
  final String url;
  const GlobalPdfViewer({Key? key, required this.url}) : super(key: key);

  @override
  State<GlobalPdfViewer> createState() => _GlobalPdfViewerState();
}

class _GlobalPdfViewerState extends State<GlobalPdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Xarvis.genericText(text: "View PDF", textColor: Xarvis.appBgColor, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      body: SfPdfViewer.network(widget.url),
    );
  }
}
