import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothConnection extends StatefulWidget {
  const BluetoothConnection({super.key});

  @override
  State<BluetoothConnection> createState() => _BluetoothConnectionState();
}

class _BluetoothConnectionState extends State<BluetoothConnection> {
  late PrinterBluetoothManager printerManager;
  List<PrinterBluetooth> _devices = [];
  PrinterBluetooth? selectedDevice;
  final MethodChannel _methodChannel = const MethodChannel('bluetooth_helper');
  int? selectedIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StreamBuilder<bool>(
        stream: printerManager.isScanningStream,
        initialData: false,
        builder: (c, snapshot) {
          if (snapshot.data!) {
            return FloatingActionButton(
              onPressed: _stopScanDevices,
              backgroundColor: Colors.red,
              child: const Icon(Icons.stop),
            );
          } else {
            return FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () => _startScanDevices(),
              child: const Icon(Icons.search),
            );
          }
        },
      ),
      backgroundColor: primary.value.withOpacity(0.2),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24)),
              margin: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width*0.5,
                      height: 68,
                      child: Center(
                        
                      ),
                    ),
                  
                ],
              ),
            ),
          ),
          
        ],
      ),
    );
  }

    void _stopScanDevices() {
    printerManager.stopScan();
  }

    void _startScanDevices() async {
    setState(() {
      _devices = [];
    });
    PermissionStatus status = await Permission.bluetooth.status;
    await Permission.bluetoothConnect.request();
    await Permission.bluetoothScan.request();
    await Permission.locationWhenInUse.request();
    if (status.isDenied) {
      await Permission.bluetooth.request();
      // await Permission.bluetoothConnect.request();
      // await Permission.bluetoothScan.request();
      await Permission.locationWhenInUse.request();
    }
    if (await Permission.bluetooth.isGranted &&
        await Permission.locationWhenInUse.isGranted) {
      printerManager.startScan(const Duration(seconds: 5));
    } else {
      // Handle the case when permissions are not granted
    }
  }
Future<void> checkAndEnableBluetooth() async {
    bool isBluetoothOn = await _methodChannel.invokeMethod('checkBluetooth');
    if (!isBluetoothOn) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Turn On Bluetooth'),
            content:
                const Text('Please turn on Bluetooth to use this feature.'),
            actions: [
              MaterialButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.of(context).pop(),
              ),
              MaterialButton(
                child: const Text('Turn On'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  await _methodChannel.invokeMethod('requestEnableBluetooth');
                },
              ),
            ],
          );
        },
      );
    }
  }
}
