import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

const MethodChannel channel = MethodChannel('com.imin.printersdk');

class _MyHomePageState extends State<MyHomePage> {
  ValueNotifier<String> stateNotifier = ValueNotifier("");
  ValueNotifier<String> libsNotifier = ValueNotifier("");
  ValueNotifier<String> scanNotifier = ValueNotifier("");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: [
                  const Text("iminPrinterSDK.jar:"),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        clickBtn("init", () async {
                          stateNotifier.value = await channel.invokeMethod("sdkInit");
                        }),
                        clickBtn("getStatus", () async {
                          stateNotifier.value =
                              "getStatus : ${await channel.invokeMethod("getStatus")}";
                        }),
                        clickBtn("print samples", () async {
                          stateNotifier.value = await channel.invokeMethod(
                            "print samples",
                            ["hello is woring good", "YES, its good", "smaple print model test"],
                          );
                        }),
                        clickBtn("printBitmap", () async {
                          final ByteData bytes = await rootBundle.load('images/icon.png');
                          //bytes.buffer.asUint8List();
                          stateNotifier.value =
                          await channel.invokeMethod("printBitmap", {
                            'image': bytes.buffer.asUint8List(),
                            'type': 'image/png',
                            'name': 'icon.png'
                          });
                        }),
                        ValueListenableBuilder(
                            valueListenable: stateNotifier,
                            builder: (context, String value, child) {
                              return Text(value);
                            })
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.red,
              ),
              Row(
                children: [
                  const Text("IminLibs1.0.15.jar:"),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        clickBtn("getSn", () async {
                          libsNotifier.value =
                              "sn:${await channel.invokeMethod("getSn")}";
                          print('sn=${libsNotifier.value}');
                        }),
                        clickBtn("opencashBox", () async {
                          libsNotifier.value =
                              "${await channel.invokeMethod("opencashBox")}";
                        }),
                        ValueListenableBuilder(
                            valueListenable: libsNotifier,
                            builder: (context, String value, child) {
                              return Text(value);
                            })
                      ],
                    ),
                  )
                ],
              ),
              const Divider(
                color: Colors.red,
              ),
            ],
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget clickBtn(String title, VoidCallback? onPressed) {
    return Padding(
      padding: const EdgeInsets.only(right: 20, left: 20),
      child: MaterialButton(
        onPressed: onPressed,
        color: Colors.blue,
        textColor: Colors.white,
        child: Text(title),
      ),
    );
  }
}
