part of 'bluethooth_connection_cubit.dart';

@immutable
abstract class PrinterConnectivityState {}

class PrinterConnectivityInitial extends PrinterConnectivityState {}

class PrinterConnectivityLoading extends PrinterConnectivityState {}

class PrinterSearching extends PrinterConnectivityState {}

class PrinterSearchingCompleted extends PrinterConnectivityState {
  // final Stream<List<BluetoothDevice>> btDevices;
  // PrinterSearchingCompleted({
  // required this.btDevices,
  // });
}

class PrinterConnected extends PrinterConnectivityState {}

class PrinterSearchingFailed extends PrinterConnectivityState {
  final String errorText;
  PrinterSearchingFailed({
    required this.errorText,
  });
}
