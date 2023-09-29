import 'package:flutter/material.dart';

showSnackBar(BuildContext context, String text) {
  final snackBar = SnackBar(
    width: 500,
    content: Center(
      child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    ),
    backgroundColor: Colors.black,
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
