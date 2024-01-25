import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/extensions/date_time.extension.dart';

part './components/helpers.dart';

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
    debugPrint('printer response : $res');
  }

  Future<void> _printText(
    String text, {
    bool bold = false,
    bool underLine = false,
    int size = 24,
    double underLineHeight = 4,
    double textLineSpacing = 2,
    PrintAlignment alignment = PrintAlignment.center,
  }) async {
    final args = {
      'text': text,
      'bold': bold,
      'alignment': setAlignment(alignment),
      'underLineHeight': underLineHeight,
      'textLineSpacing': textLineSpacing,
      'size': size,
      'underline': underLine,
    };
    final res = await _channel.invokeMethod("printText", args);
    debugPrint('printer response : $res');
  }

  Future<void> _printRow(
    List<String> texts, {
    List<int> widths = const [],
    List<PrintAlignment> aligns = const [PrintAlignment.left, PrintAlignment.right],
    List<int> sizes = const [24, 24],
  }) async {
    final args = {
      'texts': texts,
      'aligns': aligns.map((e) => setAlignment(e)).toList(),
      'widths': widths,
      'sizes': sizes,
    };
    final res = await _channel.invokeMethod("createRow", args);
    debugPrint('printer response : $res');
  }

  Future<void> _cutPaper() async {
    final res = await _channel.invokeMethod("cutPaper");
    debugPrint('printer response : $res');
  }

  Future<void> _printBlankSpace(int size) async {
    final res = await _channel.invokeMethod("blankSpacePrint", size);
    debugPrint('printer response : $res');
  }

  Future<void> printKOT(RecieptModel model) async {
    await _printBlankSpace(8);
    await _printText('KOT', bold: true, size: 35);
    await _printBlankSpace(5);
    await _printText('Bill Number : ${model.id?.substring(4, 8)}', alignment: PrintAlignment.left);
    await _printText('Time : ${model.date?.order} / ${model.time}', alignment: PrintAlignment.left);
    await _printText('------------------------------------------------------------------------');
    await _printBlankSpace(10);
    for (var e in model.products!) {
      await _printText(e.name ?? '', alignment: PrintAlignment.left, size: 28);
      await _printText(' ${e.count ?? 0} x ${e.price ?? 0}.00         ₹${(e.count ?? 0) * (e.price ?? 0)}.00', alignment: PrintAlignment.right, size: 28, bold: true);
      await _printText('------------------------------------------------------------------------');
    }
    await _printBlankSpace(150);
    await _cutPaper();
  }

  Future<void> print(RecieptModel model) async {
    //* top
    await _printBlankSpace(8);
    await _printText('Bamboo Mess', bold: true, size: 33);
    await _printBlankSpace(5);
    await _printText('7025 220748', bold: true, size: 30);
    await _printBlankSpace(2);
    await _printText('Traffic Junction');
    await _printText('Sulthan Bathery');
    await _printText('04936 220748');
    await _printText('FSSAI 11322012000137');
    await _printText('GST 32BIGPA9817C1ZP');
    await _printBlankSpace(8);
    await _printText('Employee : Owner', alignment: PrintAlignment.left, size: 27);
    await _printText('POS : POS 1', alignment: PrintAlignment.left, size: 27);
    await _printText('Bill Number : ${model.id?.substring(4, 8)}', alignment: PrintAlignment.left);
    await _printText('Time : ${model.date?.order} / ${model.time}', alignment: PrintAlignment.left);
    await _printText('------------------------------------------------------------------------');
    await _printText('Dine in', alignment: PrintAlignment.left, size: 30);
    await _printText('------------------------------------------------------------------------');
    await _printBlankSpace(4);

    //* products
    for (var e in model.products!) {
      await _printText(e.name ?? '', alignment: PrintAlignment.left, size: 28);
      await _printText(' ₹${(e.count ?? 0) * (e.price ?? 0)}.00', alignment: PrintAlignment.right, size: 28);
      await _printText(' ${e.count ?? 0} x ${e.price ?? 0}.00 ', alignment: PrintAlignment.left, size: 23);
      // await _printBlankSpace(2);
      await _printText('------------------------------------------------------------------------');
    }

    //* total amount
    // await _printBlankSpace(5);
    await _printText('Total : ₹${model.totalAmount}', bold: true, size: 40, alignment: PrintAlignment.right);
    await _printText('------------------------------------------------------------------------');

    //* bottom
    await _printBlankSpace(8);
    await _printText('Thank you');
    await _printText('Visit Again');
    await _printBlankSpace(100);
    await _cutPaper();
  }
}
