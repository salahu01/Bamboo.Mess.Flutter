// ignore_for_file: use_build_context_synchronously

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/core/services/printer/printer.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/sales/providers/sales.provider.dart';
import 'package:flutter/material.dart';

class UploadRecieptNotifier extends StateNotifier<String> {
  UploadRecieptNotifier() : super('Charge Amount');

  void createReciept(RecieptModel reciept, ref, ctx) async {
    try {
      state = 'Loading...';
      final savedReciept = await MongoDataBase().insertReciept(reciept);
      await Printer.instance.print(savedReciept);
      final selected = ref.read(selectedBillProvider);
      if (selected != null) {
        await LocalDataBase().removeProducts(selected);
      }
      ref
        ..read(billProductProvider.notifier).clearProducts()
        ..read(selectedBillProvider.notifier).update((state) => state = null)
        ..refresh(storedBillsProvider);
      Navigator.pop(ctx);
      alertBox(ctx, reciept);
    } catch (e) {
      state = 'Retry';
    }
  }

  alertBox(BuildContext context, RecieptModel reciept) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Row(
            children: [
              Spacer(),
              Text('Do You Want Kot Print?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28)),
              Spacer(),
            ],
          ),
          titleTextStyle: const TextStyle(fontSize: 24, color: Colors.black, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          content: const SingleChildScrollView(
            child: Column(
              children: [SizedBox(height: 100, width: 600)],
            ),
          ),
          actions: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary.value,
                ),
                child: const Center(child: Text('No', style: TextStyle(color: Colors.white, fontSize: 23))),
              ),
            ),
            const SizedBox(width: 20),
            InkWell(
              onTap: () async {
                Printer.instance.printKOT(reciept);
                Navigator.pop(context);
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: primary.value,
                ),
                child: const Center(child: Text('Yes', style: TextStyle(color: Colors.white, fontSize: 23))),
              ),
            ),
          ],
        );
      },
    );
  }
}
