// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'dart:developer';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart' as bt;
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/material.dart';
import 'package:freelance/src/modules/bluetooth_connection/model/bluethooth_model.dart';
import 'package:freelance/src/core/esc_pos_utils.dart' as escpos;
part 'bluethooth_connection_state.dart';

class PrinterConnectivityCubit extends Cubit<PrinterConnectivityState> {
  PrinterConnectivityCubit() : super(PrinterConnectivityInitial());
  bt.PrinterBluetoothManager printerBluetoothManager =
      bt.PrinterBluetoothManager();
  bt.PrinterBluetooth? selectedDevice;
  int? selectedIndex;
  // List<AndroidSettingsmodel> appSettings = [];
  bool hideOb = false;

  Future<List<int>> generateBtPrint({
    String? shopName,
    String? shopAddress,
    String? mobileNumber,
    String? gstIn,
    String? invoiceNumber,
    DateTime? dateTime,
    String? salesMan,
    String? customer,
    String? address,
    String? salesType,
    String? total,
    String? totalCGST,
    String? totalSGST,
    String? otherDiscount,
    String? ob,
    String? cashRecieved,
    String? netBalance,
    String? otherCharges,
    String? frieghtCharges,
    String? grandTotal,
    String? remarks,
    String? balance,
    bool? isForVoucher,
    bool? isReceipt,
    String? voucherHeader,
  }) async {
    final profile = await escpos.CapabilityProfile.load();
    return _generate80mmBTReciept(
      profile,
      cashRecieved: cashRecieved,
      frieghtCharges: frieghtCharges,
      grandTotal: grandTotal,
      mobileNumber: mobileNumber,
      netBalance: netBalance,
      ob: ob,
      otherCharges: otherCharges,
      otherDiscount: otherDiscount,
      shopAddress: shopAddress,
      shopName: shopName,
      total: total,
      totalCGST: totalCGST,
      totalSGST: totalSGST,
      address: address,
      customer: customer,
      dateTime: dateTime,
      gstIn: gstIn,
      invoiceNumber: invoiceNumber,
      salesMan: salesMan,
      salesType: salesType,
      voucherHeader: voucherHeader,
      isReceipt: isReceipt,
      isForVoucher: isForVoucher,
    );
  }
}

Future<List<int>> _generate80mmBTReciept(
  escpos.CapabilityProfile profile, {
  String? shopName,
  String? shopAddress,
  String? mobileNumber,
  String? gstIn,
  String? invoiceNumber,
  DateTime? dateTime,
  String? salesMan,
  String? customer,
  String? address,
  String? salesType,
  String? total,
  String? totalCGST,
  String? totalSGST,
  String? otherDiscount,
  String? ob,
  String? cashRecieved,
  String? netBalance,
  String? otherCharges,
  List<PrinterItemsModel>? items,
  String? frieghtCharges,
  String? grandTotal,
  String? remarks,
  String? balance,
  bool? isForVoucher,
  bool? isReceipt,
  String? voucherHeader,
  bool? isRemark,
  bool? isOb,
  bool? isBalance,
}) async {
  log('paper size is 80MM');
  PaperSize paper = PaperSize.mm80;
  final profile = await CapabilityProfile.load();
  final Generator ticket = Generator(paper, profile);
  List<int> bytes = [];
  bytes += ticket.text(
    "qjwrsnfkjvs",
    styles: const PosStyles(
      align: PosAlign.center,
      height: PosTextSize.size2,
      width: PosTextSize.size1,
      // bold: true,
      fontType: PosFontType.fontA,
    ),
  );
  bytes += ticket.text("sjdz", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text("wkesdjfacm",
      styles: const PosStyles(align: PosAlign.center));
  bytes +=
      ticket.text("rwgse", styles: const PosStyles(align: PosAlign.center));
  bytes += ticket.text(
    "5etdkjf",
    styles: const PosStyles(align: PosAlign.center),
    linesAfter: 0,
  );

  bytes += ticket.hr(ch: "=");
  bytes += ticket.row([
    PosColumn(text: 'Inv No:gvhgvhg', width: 6),
    PosColumn(
      text: 'Date : ${DateTime.now()}',
      width: 6,
      styles: const PosStyles(align: PosAlign.left),
    ),
  ]);
  bytes += ticket.text(
    "customer:hgvnbvnb ",
    styles: const PosStyles(
      align: PosAlign.left,
    ),
  );
  bytes += ticket.text(
    "Salesman: ${salesMan ?? ""}",
    styles: const PosStyles(align: PosAlign.left),
  );
  bytes += ticket.hr(ch: "=");
  bytes += ticket.row([
    PosColumn(text: 'SN', width: 1),
    PosColumn(
        text: 'DESCRIPTION',
        width: 2,
        styles:
            const PosStyles.defaults(fontType: PosFontType.fontA, bold: false)),
    PosColumn(
        text: 'PRICE',
        width: 2,
        styles: const PosStyles(align: PosAlign.center, bold: false)),
    PosColumn(
        text: 'QTY',
        width: 1,
        styles: const PosStyles(align: PosAlign.center, bold: false)),
    PosColumn(
        text: 'GROSS',
        width: 2,
        styles: const PosStyles(align: PosAlign.center, bold: false)),
    PosColumn(
        text: 'DISC',
        width: 2,
        styles: const PosStyles(align: PosAlign.center, bold: false)),
    PosColumn(
      text: 'TOTAL',
      width: 2,
      styles: const PosStyles(align: PosAlign.center, bold: false),
    ),
  ]);
  bytes += ticket.hr(ch: "=");
  for (var i = 0; i < 10; i++) {
    bytes += ticket.row([
      PosColumn(text: '${i + 1}', width: 1),
      PosColumn(
          text: "jb,mbmn m",
          width: 11,
          styles: const PosStyles.defaults(
              bold: false, fontType: PosFontType.fontA)),
    ]);
    bytes += ticket.row([
      PosColumn(
          text: '', width: 1, styles: const PosStyles.defaults(bold: false)),
      PosColumn(
          text: "", width: 2, styles: const PosStyles.defaults(bold: false)),
      PosColumn(
          text: "uhtrkgjesdrj",
          width: 2,
          styles:
              const PosStyles.defaults(align: PosAlign.center, bold: false)),
      PosColumn(
          text: "wliurtkgdjf",
          width: 1,
          styles:
              const PosStyles.defaults(align: PosAlign.center, bold: false)),
      PosColumn(
          text: "weksrhjg,semdf",
          width: 2,
          styles:
              const PosStyles.defaults(align: PosAlign.center, bold: false)),
      PosColumn(
          text: "eiorgkjerdf,m",
          width: 2,
          styles:
              const PosStyles.defaults(align: PosAlign.center, bold: false)),
      PosColumn(
          text: "erjfklher.dnt,fm ",
          width: 2,
          styles:
              const PosStyles.defaults(align: PosAlign.center, bold: false)),
    ]);
  }
  bytes += ticket.hr(ch: "=");
  bytes += ticket.text(
    "Total:  ",
    styles: const PosStyles(
      align: PosAlign.right,
      bold: true,
    ),
  );
  otherDiscount != "0.00"
      ? bytes += ticket.text(
          "Other Discount:  ",
          styles: const PosStyles(
            align: PosAlign.right,
          ),
        )
      : null;
  frieghtCharges != "0.00"
      ? bytes += ticket.text(
          "Freight charge:  ",
          styles: const PosStyles(
            align: PosAlign.right,
          ),
        )
      : null;
  otherCharges != "0.00"
      ? bytes += ticket.text(
          "Other Charge:  ",
          styles: const PosStyles(
            align: PosAlign.right,
          ),
        )
      : null;

  bytes += ticket.text(
    "Grand Total:   ",
    styles: const PosStyles(
      align: PosAlign.right,
      bold: true,
    ),
  );

  bytes += ticket.text(
    "Cash Recieved:  ",
    styles: const PosStyles(
      align: PosAlign.right,
    ),
  );
  bytes += ticket.text(
    "Net Balance:   ",
    styles: const PosStyles(
      align: PosAlign.right,
      bold: true,
    ),
  );
  bytes += ticket.hr(ch: "=");
  bytes += ticket.text("Thank You",
      styles: const PosStyles(
        height: PosTextSize.size1,
        width: PosTextSize.size1,
        align: PosAlign.center,
        fontType: PosFontType.fontA,
        bold: false,
      ),
      linesAfter: 3);
  ticket.feed(2);
  ticket.cut();
  return bytes;
}
