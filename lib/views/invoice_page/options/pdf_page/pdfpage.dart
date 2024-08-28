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
    // 1. Generate object
    pw.Document pdf = pw.Document();

    // 2. Add and design Page
    pdf.addPage(
      pw.Page(
        margin: const pw.EdgeInsets.all(20),
        build: (pw.Context cnt) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            // Invoice Header
            pw.Text(
              'Invoice',
              style: pw.TextStyle(
                fontSize: 24,
                fontWeight: pw.FontWeight.bold,
              ),
            ),
            pw.SizedBox(height: 20),

            // Invoice Details
            pw.Text('Invoice Number: ${Globals.inv_num ?? ''}'),
            pw.Text('Customer Name: ${Globals.name ?? ''}'),
            pw.Text(
                'Invoice Date: ${Globals.date != null ? DateFormat.yMd().format(Globals.date!) : ''}'),
            pw.SizedBox(height: 20),

            // Product List
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
              data: Globals.products.map((product) {
                final price = double.tryParse(product['price']) ?? 0;
                final quantity = int.tryParse(product['quantity']) ?? 0;
                final total = price * quantity;
                return [
                  product['name'],
                  price.toStringAsFixed(2),
                  quantity.toString(),
                  total.toStringAsFixed(2)
                ];
              }).toList(),
              border: pw.TableBorder.all(),
              headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
              headerDecoration:
                  const pw.BoxDecoration(color: PdfColors.grey300),
              cellAlignment: pw.Alignment.centerLeft,
            ),
            pw.SizedBox(height: 20),

            // Footer
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
            Navigator.of(context).popAndPushNamed(AppRoutes.homepage);
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
      ),
      body: PdfPreview(
        pdfFileName: "INVOICE_${Globals.name?.toUpperCase()}",
        build: (format) => getPdf(),
      ),
    );
  }
}
