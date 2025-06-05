import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
class UploadedOn extends StatefulWidget {
  const UploadedOn({super.key});

  @override
  State<UploadedOn> createState() => _UploadedOnState();
}

class _UploadedOnState extends State<UploadedOn> {
  @override
  Widget build(BuildContext context) {
    final documentUrl = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Center(
        child: documentUrl.isNotEmpty
            ?  PDFView(
          filePath: documentUrl,
        )
            : const Text('No image available'),
      ),
    );
  }
}
