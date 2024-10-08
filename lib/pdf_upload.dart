import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'dart:io';





class PDFUploader extends StatefulWidget {
  @override
  _PDFUploaderState createState() => _PDFUploaderState();
}

class _PDFUploaderState extends State<PDFUploader> {
  File? _pdfFile;

  Future<void> _pickPDF() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _pdfFile = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Uploader'),
      ),
      body: Center(
        child: _pdfFile == null
            ? ElevatedButton(
          onPressed: _pickPDF,
          child: Text('Upload PDF'),
        )
            : PDFViewerScreen(pdfFile: _pdfFile!),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final File pdfFile;

  PDFViewerScreen({required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('View PDF'),
      ),
      body: SfPdfViewer.file(pdfFile),
    );
  }
}
