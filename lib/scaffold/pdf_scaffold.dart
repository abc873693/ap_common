import 'dart:typed_data';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';
import 'package:printing/printing.dart';
import 'package:pdf/pdf.dart';

enum PdfState { loading, finish, error }

class PdfScaffold extends StatefulWidget {
  final PdfState state;
  final Function onRefresh;
  final Uint8List data;

  PdfScaffold({
    Key key,
    @required this.state,
    this.onRefresh,
    this.data,
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
        return PdfPreview(
          build: (PdfPageFormat format) async {
            return widget.data;
          },
          useActions: false,
        );
    }
  }

  Widget get errorContent => InkWell(
        onTap: () {
          if (widget.onRefresh != null) widget.onRefresh();
        },
        child: HintContent(
          icon: ApIcon.error,
          content: ApLocalizations.of(context).clickToRetry,
        ),
      );
}
