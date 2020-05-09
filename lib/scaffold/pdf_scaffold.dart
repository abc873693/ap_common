import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

class PdfScaffold extends StatefulWidget {
  final Uint8List byteList;

  const PdfScaffold({Key key, this.byteList}) : super(key: key);

  @override
  _PdfScaffoldState createState() => _PdfScaffoldState();
}

class _PdfScaffoldState extends State<PdfScaffold> {
  PdfController pdfController;

  @override
  void initState() {
    pdfController = PdfController(
      document: PdfDocument.openData(widget.byteList),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PdfView(
      controller: pdfController,
    );
  }
}
