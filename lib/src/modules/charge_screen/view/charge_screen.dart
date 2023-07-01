import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/core/theme/app_colors.dart';

class ChargeScreen extends StatefulWidget {
  const ChargeScreen({super.key});

  @override
  State<ChargeScreen> createState() => _ChargeScreenState();
}

class _ChargeScreenState extends State<ChargeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 120,
          backgroundColor: primary.value,
          systemOverlayStyle:
              SystemUiOverlayStyle.light.copyWith(statusBarColor: Colors.black),
          leadingWidth: 120,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 35,
            ),
          ),
        ),
        body: Column(
          children: [
            
          ],
        ));
  }
}
