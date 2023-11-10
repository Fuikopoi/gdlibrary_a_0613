import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:intl/intl.dart';
import 'package:gdlibrary_a_0613/invoice/get_total_invoice.dart';
import 'package:gdlibrary_a_0613/invoice/model/custom_row_invoice.dart';
import 'package:gdlibrary_a_0613/invoice/model/product.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:gdlibrary_a_0613/preview_screen.dart';
import 'package:gdlibrary_a_0613/invoice/item_doc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

Future<void> createPdf
(
  TextEditingController nameController,
  TextEditingController phoneController,
  TextEditingController addressController,
  String id,
  File image,
  BuildContext context,
  List<Product> soldProducts
) async{
  final doc = pw.Document();
  final now = DateTime.now();
  final formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(now);

  final imageLogo = 
      (await rootBundle.load("assets/logo.png")).buffer.asUint8List();
  final imageInvoice = pw.MemoryImage(imageLogo);

  pw.ImageProvider PdfImageProvider(Uint8List imageBytes){
    return pw.MemoryImage(imageBytes);
  }

  final imageBytes = image.readAsBytesSync();

  final psfTheme = pw.PageTheme(
    pageFormat: PdfPageFormat.a4,
    buildBackground: (pw.Context context) {
            return pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(
            color: PdfColor.fromHex('#FFBD59'),
            width: 1.w,
          ),
        ),
      );
    ),
  };


//pahe 44