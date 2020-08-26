import 'dart:typed_data';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';
import 'package:native_pdf_view/native_pdf_view.dart';

enum PdfState { loading, finish, error }

class PdfScaffold extends StatefulWidget {
  final PdfState state;
  final Uint8List byteList;
  final Function onRefresh;

  PdfScaffold({
    Key key,
    @required this.state,
    @required this.byteList,
    this.onRefresh,
  }) : super(key: key) {
    assert(this.state != null);
  }

  @override
  _PdfScaffoldState createState() => _PdfScaffoldState();
}

class _PdfScaffoldState extends State<PdfScaffold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case PdfState.loading:
        return Container(
          child: CircularProgressIndicator(),
          alignment: Alignment.center,
        );
      case PdfState.error:
        return errorContent;
      default:
        if (widget.byteList == null)
          return errorContent;
        else
          return PdfView(
            controller: PdfController(
              document: PdfDocument.openData(widget.byteList),
            ),
          );
    }
  }

  Widget get errorContent => FlatButton(
        onPressed: () {
          if (widget.onRefresh != null) widget.onRefresh();
        },
        child: HintContent(
          icon: ApIcon.error,
          content: ApLocalizations.of(context).clickToRetry,
        ),
      );
}
