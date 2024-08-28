import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../../../../routes/all_routes.dart';
import '../../../../utils/globals.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({super.key});

  @override
  State<PdfPage> createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
  Future<Uint8List> getPdf() {
    Globals.totalbill = 0.0;

    // 1. Generate object
    pw.Document pdf = pw.Document();

    // 2. Design Page
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context cnt) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text(
              '${Globals.cmp_name ?? ''} ',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text('Customer Name: ${Globals.name ?? ''}'),
            pw.Text('Customer Contact: ${Globals.contact ?? ''}'),
            pw.SizedBox(height: 20),
            pw.Text(
              'Products',
              style: pw.TextStyle(
                fontSize: 18,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 10),
            pw.TableHelper.fromTextArray(
              headers: ['Product Name', 'Price', 'Quantity', 'Total'],
              data: Globals.products.map((e) {
                final price = double.tryParse(e['price']) ?? 0;
                final quantity = int.tryParse(e['qty']) ?? 0;
                final total = price * quantity;
                Globals.totalbill = Globals.totalbill! + total;
                return [
                  e['name'],
                  price.toStringAsFixed(2),
                  quantity.toString(),
                  total.toStringAsFixed(2)
                ];
              }).toList(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'GST (18%): ${(Globals.totalbill! * 0.18).toStringAsFixed(2)}',
              style: pw.TextStyle(
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text(
              'Total: ${(Globals.totalbill! * 1.18).toStringAsFixed(2)}',
              style: pw.TextStyle(
                fontSize: 16,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.Text('Thank You For Shopping!'),
          ],
        ),
      ),
    );

    // 3. Save pdf
    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("PDF Page"),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.productdata);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.homepage);
            },
            icon: const Icon(Icons.home),
          ),
        ],
      ),
      body: PdfPreview(
        pdfFileName: "INVOICE_${Globals.name?.toUpperCase()}",
        build: (format) => getPdf(),
      ),
    );
  }
}
