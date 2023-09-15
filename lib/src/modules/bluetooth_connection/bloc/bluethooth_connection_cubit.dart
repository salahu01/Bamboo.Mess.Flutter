// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'dart:developer';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as bt;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:freelance/src/core/widgets/esc_pos_utils.dart' as escpos;
part 'bluethooth_connection_state.dart';

class PrinterConnectivityCubit extends Cubit<PrinterConnectivityState> {
  PrinterConnectivityCubit() : super(PrinterConnectivityInitial());
  bt.PrinterBluetoothManager printerBluetoothManager = bt.PrinterBluetoothManager();
  bt.PrinterBluetooth? selectedDevice;
  int? selectedIndex;

  Future<List<int>> generateBtPrint({String? shopAddress, String? gstIn, String? invoiceNumber, DateTime? dateTime, String? salesMan, String? total}) async {
    final profile = await escpos.CapabilityProfile.load();
    return _generate80mmBTReciept(profile, shopAddress: shopAddress, total: total, dateTime: dateTime, gstIn: gstIn, invoiceNumber: invoiceNumber, salesMan: salesMan);
  }
}

Future<List<int>> _generate80mmBTReciept(escpos.CapabilityProfile profile, {String? shopAddress, String? gstIn, String? invoiceNumber, DateTime? dateTime, String? salesMan, String? total}) async {
  log('paper size is 80MM');
  PaperSize paper = PaperSize.mm80;
  final profile = await CapabilityProfile.load();
  final Generator ticket = Generator(paper, profile);
  List<int> bytes = [];
  bytes += ticket.text(
    "BAMBBO MESS",
    styles: const PosStyles(align: PosAlign.center, height: PosTextSize.size2, width: PosTextSize.size1, bold: true, fontType: PosFontType.fontA),
  );
  bytes += ticket.text("Traffic Junction", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text("Sulthan Bathery", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text("04936 220748", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text("70252 20748", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text("FSSAI  11322012000137", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text("GST  32BIGPA9817CIZP", styles: const PosStyles(align: PosAlign.center));

  bytes += ticket.hr(ch: "=");
  bytes += ticket.row([
    PosColumn(text: 'Bill No:  200', width: 6),
    PosColumn(text: 'Date : ${DateTime.now()}', width: 6, styles: const PosStyles(align: PosAlign.left)),
  ]);
  bytes += ticket.text("Employee: ${salesMan ?? ""}", styles: const PosStyles(align: PosAlign.right));
  bytes += ticket.hr(ch: "=");
  bytes += ticket.row([
    PosColumn(text: 'SN', width: 2),
    PosColumn(text: 'ITEMS', width: 4, styles: const PosStyles.defaults(fontType: PosFontType.fontA, bold: false)),
    PosColumn(text: 'QTY', width: 2, styles: const PosStyles(align: PosAlign.center, bold: false)),
    PosColumn(text: 'TOTAL', width: 4, styles: const PosStyles(align: PosAlign.center, bold: false)),
  ]);
  bytes += ticket.hr(ch: "=");
  for (var i = 0; i < 2; i++) {
    bytes += ticket.row([
      PosColumn(text: '${i + 1}         ', width: 1),
      PosColumn(text: "chappathi", width: 11, styles: const PosStyles.defaults(bold: false, fontType: PosFontType.fontA)),
    ]);
    bytes += ticket.row([
      PosColumn(text: "3", width: 6, styles: const PosStyles.defaults(align: PosAlign.center, bold: false)),
      PosColumn(text: "100", width: 6, styles: const PosStyles.defaults(align: PosAlign.center, bold: false)),
    ]);
  }
  bytes += ticket.hr(ch: "=");
  bytes += ticket.text("Total Amount:    ", styles: const PosStyles(align: PosAlign.right, bold: true));

  bytes += ticket.hr(ch: "=");
  bytes += ticket.text("Thank You Visit Again !",
      styles: const PosStyles(height: PosTextSize.size1, width: PosTextSize.size1, align: PosAlign.center, fontType: PosFontType.fontA, bold: true), linesAfter: 3);
  ticket.feed(2);
  ticket.cut();
  return bytes;
}
