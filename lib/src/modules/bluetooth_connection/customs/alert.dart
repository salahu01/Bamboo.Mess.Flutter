import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class Utils {
  Utils._();

  static showMessageBar(BuildContext context,
      {required String message, required String type}) {
    Flushbar(
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 98),
      isDismissible: true,
      duration: const Duration(seconds: 3),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      backgroundColor: type.toLowerCase() == 'error'
          ? Colors.red
          : const Color(0xFF1d1c2b),
      icon: const Icon(Icons.error_outline, color: Colors.white),
      messageText: Text(
        message,
        maxLines: 3,
        style: const TextStyle(fontSize: 14, color: Colors.white),
      ),
    ).show(context);
  }
}