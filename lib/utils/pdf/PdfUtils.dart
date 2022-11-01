import 'dart:io';

import 'package:fishcount_app/utils/pdf/PDFViewerPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart';
import 'package:file_saver/file_saver.dart';


class PdfUtils {

  static Future<File> loadPdf() async {
    const file = 'documents/politica_de_privacidade.pdf';

    final data = await rootBundle.load(file);

    final bytes = data.buffer.asUint8List();

    return storeFile(file, bytes);
  }

  static Future<File> storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();

    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);

    return file;
  }

  static void openPDF(BuildContext context, File file) => Navigator.of(context).push(
    MaterialPageRoute(builder: (context) => PDFViewerPage(file: file)),
  );

}