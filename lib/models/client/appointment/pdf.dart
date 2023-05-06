import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PdfPage extends StatefulWidget {
  final String name;

  const PdfPage({Key? key, required this.name}) : super(key: key);

  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  late pw.Document pdf;
  Future<pw.MemoryImage> _loadImage() async {
    final byteData = await rootBundle.load('assets/logoss.jpg');
    return pw.MemoryImage(byteData.buffer.asUint8List());
  }

  @override
  void initState() {
    super.initState();

    // Create a new PDF document
    pdf = pw.Document();

    // Add a page to the document
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Center(
          child: pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.center,
            children: [
              // Add the company logo to the document
              // pw.Image(
              //   await _loadImage(),
              // ),

              pw.SizedBox(height: 30),
              // Add the user's name to the document
              pw.Text(
                'Hello ${widget.name},',
                style: pw.TextStyle(fontSize: 20),
              ),
              pw.SizedBox(height: 30),
              // Add other details to the document
              pw.Text(
                'Here are some other details:',
                style: pw.TextStyle(fontSize: 16),
              ),
              pw.SizedBox(height: 10),
              pw.Text('Detail 1'),
              pw.Text('Detail 2'),
              pw.Text('Detail 3'),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Download PDF'),
          onPressed: () async {
  // Get the app's documents directory
  final directory = await getApplicationDocumentsDirectory();
  final path = '${directory.path}/appointment.pdf';

  // Save the PDF document to the device
  final file = File(path);
  await file.writeAsBytes(await pdf.save());

  // Open the PDF document in a PDF viewer app
  await Navigator.of(context).push(
    MaterialPageRoute(
      builder: (_) => PdfViewerPage(path: path),
    ),
  );
},
        ),
      ),
    );
  }
}

class PdfViewerPage extends StatelessWidget {
  final String path;

  const PdfViewerPage({Key? key, required this.path}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF Viewer'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Open PDF'),
          onPressed: () async {
            if (await canLaunchUrl(Uri.parse(path))) {
              await launchUrl(Uri.parse(path));
            } else {
              throw 'Could not launch $path';
            }
          },
        ),
      ),
    );
  }
}
