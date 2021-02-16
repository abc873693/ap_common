import 'dart:typed_data';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/analytics_utils.dart';
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
  final String fileName;

  PdfScaffold({
    Key key,
    @required this.state,
    this.onRefresh,
    this.data,
    this.fileName,
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
        return Scaffold(
          body: PdfPreview(
            build: (PdfPageFormat format) async {
              return widget.data;
            },
            useActions: false,
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                child: Icon(ApIcon.share),
                onPressed: () async {
                  AnalyticsUtils.instance?.logEvent('export_by_share');
                  await Printing.sharePdf(
                    bytes: widget.data,
                    filename: '${widget.fileName ?? 'export'}.pdf',
                  );
                },
              ),
              SizedBox(height: 16.0),
              FloatingActionButton(
                child: Icon(ApIcon.print),
                onPressed: () async {
                  AnalyticsUtils.instance?.logEvent('export_by_printing');
                  await Printing.layoutPdf(
                    onLayout: (format) async => widget.data,
                    name: widget.fileName ?? 'export',
                  );
                },
              ),
            ],
          ),
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
