import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/core/models/reciept.model.dart';

part './components/helpers.dart';
part './components/text_print.dart';

@immutable
final class Printer {
  //*
  static const instance = Printer._();

  //*
  const Printer._();

  //* Which channel
  final _channel = const MethodChannel('com.i_min.printer_sdk');

  Future<void> initSdk() async {
    final res = await _channel.invokeMethod("sdkInit");
    debugPrint(res);
  }

  Future<void> _printText(PrintText text) async {
    final res = await _channel.invokeMethod("printText", text.toJson());
    debugPrint(res);
  }

  Future<void> print(List<RecieptProduct> products) async {
    //* creating bill
    const bill = <PrintText>[
      PrintText('Bamboo Mess\n', bold: true, size: 32),
      PrintText('Traffic Junction'),
      PrintText('Sulthan Bathery'),
      PrintText('04936 220748'),
      PrintText('7025 220748'),
      PrintText('FSSAI 11322012000137'),
      PrintText('GST 32BIGPA9817C1ZP\n\n'),
      PrintText('Employee: Owner', alignment: PrintAlignment.left),
      PrintText('POS: POS 1', underLine: true, alignment: PrintAlignment.left),
      PrintText('Dine in\n', alignment: PrintAlignment.left),
      PrintText('Chappathi', alignment: PrintAlignment.left),
      PrintText('3 x 13.00 = 39.0\n', alignment: PrintAlignment.left),
      PrintText('Egg Masala (Single)', alignment: PrintAlignment.left),
      PrintText('1 x 50.00 = 50.0\n', underLine: true, alignment: PrintAlignment.left),
      PrintText('Total  : 89.00\n', bold: true, size: 32, alignment: PrintAlignment.left),
      PrintText('Cash  : 89.00\n', underLine: true, alignment: PrintAlignment.left),
      PrintText('Thank you'),
      PrintText('Visit Again\n'),
      PrintText('07/11/23 08:47 PM\n', alignment: PrintAlignment.left),
    ];
    //* calling printer
    for (var text in bill) {
      await _printText(text);
    }
  }
}
