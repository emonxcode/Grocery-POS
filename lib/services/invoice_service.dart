import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../models/product.dart';
import '../views/invoice_view/invoice_view.dart';


class CustomRow {
   String? pName;
   String? price;
   String? quantity;

  CustomRow(this.pName, this.price, this.quantity);
}

class PdfInvoiceService {
  Future<Uint8List> createHelloWorld() {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text("Hello World"),
          );
        },
      ),
    );

    return pdf.save();
  }

  Future<Uint8List> createInvoice(List<Product> soldProducts, int total, BuildContext ctx) async {
    final pdf = pw.Document();

    final List<CustomRow> elements = [
      
      for (var product in soldProducts)
        CustomRow(
          product.pName!,
          product.pSalePrice!.toString(),
          product.pQuantity.toString(),
        ),
    
    
  
    ];
    // final image = (await rootBundle.load("assets/flutter_explained_logo.jpg"))
    //     .buffer
    //     .asUint8List();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.legal,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text("GroceryPOS", style: pw.TextStyle(fontSize: 50, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 10),
              // pw.Image(pw.MemoryImage(image),
              //     width: 150, height: 150, fit: pw.BoxFit.cover),
             
                  pw.Text("B/44 Sarder Market, BotTola", style: pw.TextStyle(fontSize: 30)),
                  pw.Text("KhilKet, Dahaka 1229", style: pw.TextStyle(fontSize: 30)),
                  pw.Text("Mobile : 01648020313", style: pw.TextStyle(fontSize: 30)),
             
              pw.SizedBox(height: 20),
              pw.Text(
                  "SALES RECEIPT", style: pw.TextStyle(fontSize: 30, fontWeight: pw.FontWeight.bold)),
              pw.Divider(height: 2),
              pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text("Products",
                        textAlign: pw.TextAlign.left, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(
                    child: pw.Text("Price",
                        textAlign: pw.TextAlign.right, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(
                    child:
                        pw.Text("Quantity", textAlign: pw.TextAlign.right, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
            
              ],
            ),
             pw.Divider(height: 4),
              itemColumn(elements),
              pw.Divider(height: 4),
              pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text("Total",
                        textAlign: pw.TextAlign.left, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(
                    child: pw.Text("",
                        textAlign: pw.TextAlign.right, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(
                    child:
                        pw.Text("${total.toString()} TK", textAlign: pw.TextAlign.right, style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))),
            
              ],
            ),
              // pw.SizedBox(height: 25),
              // pw.Text("Thanks for buying from us, welcome!", style: pw.TextStyle(fontSize: 20)),
              // pw.SizedBox(height: 25),
              pw.Text("Software developed by : ", style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 10),
              pw.Text("Shahriar Emon", style: pw.TextStyle(fontSize: 25, fontWeight: pw.FontWeight.bold))
            ],
          );
        },
      ),
    );
    return pdf.save();
  }

  pw.Expanded itemColumn(List<CustomRow> elements) {
    return pw.Expanded(
      child: pw.Column(
        children: [
          for (var element in elements)
            pw.Row(
              children: [
                pw.Expanded(
                    child: pw.Text(element.pName!.toString(),
                        textAlign: pw.TextAlign.left, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(
                    child: pw.Text(element.price!.toString(),
                        textAlign: pw.TextAlign.right, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
                pw.Expanded(
                    child:
                        pw.Text(element.quantity!.toString(), textAlign: pw.TextAlign.right, style: pw.TextStyle(fontSize: 22, fontWeight: pw.FontWeight.bold))),
            
              ],
            )
        ],
      ),
    );
  }

  Future<void> savePdfFile(String fileName, Uint8List byteList, BuildContext context) async {
    final output = await getExternalStorageDirectory();
    var filePath = "${output!.path}/$fileName.pdf";
    final file = File(filePath);
    await file.writeAsBytes(byteList);

   Navigator.of(context).push(MaterialPageRoute(builder: ((context) => PdfView(path: filePath,))));
  }



}
