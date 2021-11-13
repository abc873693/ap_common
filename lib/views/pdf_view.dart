import 'dart:typed_data';

import 'package:ap_common/resources/ap_icon.dart';
import 'package:ap_common/utils/analytics_utils.dart';
import 'package:ap_common/utils/ap_localizations.dart';
import 'package:ap_common/widgets/hint_content.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

enum PdfState { loading, finish, error }

class PdfView extends StatefulWidget {
  final PdfState state;
  final Function()? onRefresh;
  final Uint8List? data;
  final String? fileName;

  const PdfView({
    Key? key,
    required this.state,
    this.onRefresh,
    this.data,
    this.fileName,
  }) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  @override
  void initState() {
    AnalyticsUtils.instance?.setCurrentScreen(
      'PdfView',
      'pdf_view.dart',
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state) {
      case PdfState.loading:
        return const Center(
          child: CircularProgressIndicator(),
        );
      case PdfState.error:
        return errorContent;
      default:
        return Scaffold(
          body: PdfPreview(
            build: (PdfPageFormat format) {
              return widget.data!;
            },
            useActions: false,
          ),
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () async {
                  AnalyticsUtils.instance?.logEvent('export_by_share');
                  await Printing.sharePdf(
                    bytes: widget.data!,
                    filename: '${widget.fileName ?? 'export'}.pdf',
                  );
                },
                child: Icon(ApIcon.share),
              ),
              const SizedBox(height: 16.0),
              FloatingActionButton(
                onPressed: () async {
                  AnalyticsUtils.instance?.logEvent('export_by_printing');
                  await Printing.layoutPdf(
                    name: widget.fileName ?? 'export',
                    onLayout: (PdfPageFormat format) => widget.data!,
                  );
                },
                child: Icon(ApIcon.print),
              ),
            ],
          ),
        );
    }
  }

  Widget get errorContent => InkWell(
        onTap: () {
          widget.onRefresh?.call();
        },
        child: HintContent(
          icon: ApIcon.error,
          content: ApLocalizations.of(context).clickToRetry,
        ),
      );
}
