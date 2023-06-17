import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/modules/dashboard/view/dashboard_view.dart';

void main() {
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.dark,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
        fontFamily: "montserratfamily",
      ),
      debugShowCheckedModeBanner: false,
      home:  DashBoardView(),
    );
  }
}
