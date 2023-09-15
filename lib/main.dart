import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freelance/src/core/models/reciept.model.dart';
import 'package:freelance/src/core/services/db/local.db.sevices.dart';
import 'package:freelance/src/core/services/db/remote.db.services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/src/modules/bluetooth_connection/bloc/bluethooth_connection_cubit.dart';
import 'package:freelance/src/modules/dashboard/view/dashboard_view.dart';
import 'package:freelance/src/modules/printing/printing_ui.dart';
import 'package:hive_flutter/adapters.dart';
// import 'dart:convert';
// import 'package:drago_usb_printer/drago_usb_printer.dart';

void main() async {
  await MongoDataBase().connectDb();
  await Hive.initFlutter();
  Hive.registerAdapter(RecieptProductAdapter());
  await LocalDataBase().openBox();
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
        // home: const DashBoardView(),
        home: const MyHomePage(title: "print sample"),
      ),
    );
  }
}
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   _MyAppState createState() =>  _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   List<Map<String, dynamic>> devices = [];
//   DragoUsbPrinter dragoUsbPrinter = DragoUsbPrinter();

//   @override
//   initState() {
//     super.initState();
//     _getDevicelist();
//   }

//   _getDevicelist() async {
//     List<Map<String, dynamic>> results = [];
//     results = await DragoUsbPrinter.getUSBDeviceList();

//     print(" length: ${results.length}");
//     setState(() {
//       devices = results;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('USB PRINTER'),
//           actions: <Widget>[
//            IconButton(
//                 icon: Icon(Icons.refresh),
//                 onPressed: () => _getDevicelist()),
//           ],
//         ),
//         body: devices.length > 0
//             ? ListView(
//                 scrollDirection: Axis.vertical,
//                 children: _buildList(devices),
//               )
//             : null,
//       ),
//     );
//   }

//   List<Widget> _buildList(List<Map<String, dynamic>> devices) {
//     return devices
//         .map((device) => ListTile(
//               leading: Icon(Icons.usb),
//               title: Text(
//                   device['manufacturer'] + " " + device['productName']),
//               subtitle:
//                  Text(device['vendorId'] + " " + device['productId']),
//               trailing: IconButton(
//                   icon: Icon(Icons.print),
//                   onPressed: () async {
//                     int vendorId = int.parse(device['vendorId']);
//                     int productId = int.parse(device['productId']);
//                     bool? isConnected =
//                         await dragoUsbPrinter.connect(vendorId, productId);
//                     if (isConnected ?? false) {
//                       var data = Uint8List.fromList(utf8
//                           .encode(" Hello world Testing ESC POS printer..."));
//                       await dragoUsbPrinter.write(data);
//                       await dragoUsbPrinter.close();
//                     }
//                   }),
//             ))
//         .toList();
//   }
// }
