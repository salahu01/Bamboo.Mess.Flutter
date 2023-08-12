// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'package:esc_pos_bluetooth/esc_pos_bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freelance/src/core/theme/app_colors.dart';
import 'package:freelance/src/modules/bluetooth_connection/bloc/bluethooth_connection_cubit.dart';
import 'package:freelance/src/modules/bluetooth_connection/customs/alert.dart';
import 'package:freelance/src/modules/bluetooth_connection/customs/savebutton.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothConnection extends StatefulWidget {
  const BluetoothConnection({super.key});

  @override
  State<BluetoothConnection> createState() => _BluetoothConnectionState();
}

class _BluetoothConnectionState extends State<BluetoothConnection> {
  List<PrinterBluetooth> _devices = [];
  PrinterBluetooth? selectedDevice;
 late PrinterConnectivityCubit printerConnectivityCubit;
      
  int? selectedIndex;
 late  PrinterBluetoothManager printerManager;  
 
 @override
 initState(){
  super.initState();
  printerConnectivityCubit=BlocProvider.of<PrinterConnectivityCubit>(context);
  printerManager=printerConnectivityCubit.printerBluetoothManager;
 }
 
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: StreamBuilder<bool>(
        stream: printerManager.isScanningStream,
        initialData: false,
        builder: (context, snapshot) {
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
                    // width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.9,
                    child: ListView.separated(
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 15),
                      itemCount: _devices.length,
                      itemBuilder: (BuildContext context, int index) {
                        log('selected index => $selectedIndex');
                        log("device length is ${_devices.length}");
                        return InkWell(
                          onTap: () {
                            selectedIndex = index;
                            setState(() {});
                          },
                          child: Container(
                            height: 60,
                            width: 70,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: selectedIndex == index
                                  ? const Color(0xFFfa9e18)
                                  : Colors.grey.withOpacity(.2),
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.print,
                                    color: selectedIndex == index
                                        ? Colors.white
                                        : Colors.black),
                                const SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _devices[index].name ?? '',
                                      style: TextStyle(
                                        color: selectedIndex == index
                                            ? Colors.white
                                            : Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      _devices[index].address!,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: selectedIndex != null
          ? SizedBox(
              height: 10,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: SaveButton(
                            label: "Cancel",
                            color: Colors.grey,
                            onTap: () => Navigator.pop(context))),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: BlocConsumer<PrinterConnectivityCubit,
                          PrinterConnectivityState>(
                        listener: (context, state) {
                          if (state is PrinterConnected) {
                            Utils.showMessageBar(context,
                                message:
                                    'Bluetooth Printer Successfully Connected.',
                                type: "message");
                          }
                        },
                        builder: (context, state) {
                          log(state.toString());
                          if (state is PrinterConnectivityLoading) {
                            return SaveButton(
                                label: '',
                                onTap: () {},
                                child:
                                    const CircularProgressIndicator.adaptive());
                          }
                          return SaveButton(
                              label: 'Connect',
                              onTap: () {
                                printerManager
                                    .selectPrinter(_devices[selectedIndex!]);
                                printerConnectivityCubit.selectedDevice =
                                    _devices[selectedIndex!];
                                printerConnectivityCubit.selectedIndex =
                                    selectedIndex;
                                // Navigator.pop(context);
                                Utils.showMessageBar(context,
                                    message: "Success Connected to the device",
                                    type: "message");
                              });
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
          : null,
    );
  }

  void _stopScanDevices() {
    printerManager.stopScan();
  }

  void _startScanDevices() async {
    log("_startScanDevices");
    setState(() {
      _devices = [];
    });
    PermissionStatus status = await Permission.bluetooth.status;
    final status1 = await Permission.bluetooth.isGranted;
    final status2 = await Permission.locationWhenInUse.isGranted;
    log('statusn => $status || $status1 || $status2 || ${status1 && status2}');
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
      log('here in granted permission');
      printerManager.startScan(const Duration(seconds: 5));
      printerManager.scanResults.listen((devs) {
        log('devices => $devs');
        setState(() {
          _devices = devs;
        });
      });
    } else {
      // Handle the case when permissions are not granted
    }
  }
}
