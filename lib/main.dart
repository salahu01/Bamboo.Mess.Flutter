import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/bluetooth_connection/bloc/bluethooth_connection_cubit.dart';
import 'package:freelance/src/modules/dashboard/view/dashboard_view.dart';
import 'package:hive_flutter/adapters.dart';

void main() async {
  await MongoDataBase().connectDb();
  await Hive.initFlutter();
  Hive.registerAdapter(RecieptProductAdapter());
  await LocalDataBase().openBox();
  await retriveColor();
  WidgetsFlutterBinding.ensureInitialized();
  const MethodChannel channel = MethodChannel('com.imin.printersdk');
  await channel.invokeMethod("sdkInit").catchError((e) {});
  runApp(const ProviderScope(child: MyApp()));
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
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<PrinterConnectivityCubit>(create: (_) => PrinterConnectivityCubit()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreenAccent),
          fontFamily: "montserratfamily",
        ),
        debugShowCheckedModeBanner: false,
        home: const DashBoardView(),
      ),
    );
  }
}
