import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:freelance/src/core/services/printer/printer.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/dashboard/view/dashboard_view.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await MongoDataBase().connectDb();
  await Hive.initFlutter();
  Hive.registerAdapter(RecieptProductAdapter());
  await LocalDataBase().openBox();
  await retriveColor();
  WidgetsFlutterBinding.ensureInitialized();
  await Printer.instance.initSdk();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static final navigator = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigator,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
        fontFamily: "montserratfamily",
      ),
      debugShowCheckedModeBanner: false,
      home: const DashBoardView(),
      // home: const Test(),
    );
  }
}
