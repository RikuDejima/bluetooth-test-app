import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/configs/bocco_data.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ServiceListModel with ChangeNotifier {
  List<BluetoothService> serviceList = [];

  void connectDevice(BluetoothDevice device) async {
    await device.disconnect();
    await device.connect();
    notifyListeners();
    serviceList = await device.discoverServices();
    notifyListeners();
  }
}
