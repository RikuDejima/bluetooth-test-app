import 'package:bocco_bluetooth_test/configs/bocco_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceListModel with ChangeNotifier {
  List<ScanResult> deviceList = [];
  FlutterBlue _flutterBlue = FlutterBlue.instance;
  List<Guid> _settingServiceUuids = BoccoId().settingsServiceUuids;
  Set<ScanResult> _deviceSet = {};
  bool isScanning = false;

  void addDeviceData() async {
    deviceList = [];
    _flutterBlue
        .scan(
      timeout: Duration(seconds: 8),
    )
        .listen((event) {
      List<String> acquiredServiceUuids = event.advertisementData.serviceUuids;
      if (acquiredServiceUuids.isEmpty) return;

      late Guid acquiredUuid;
      if (acquiredServiceUuids[0].length == 36) {
        acquiredUuid = Guid(acquiredServiceUuids[0]);
      } else {
        return;
      }

      _settingServiceUuids.forEach((uuid) {
        if (uuid == acquiredUuid) {
          _deviceSet.add(event);
          deviceList = _deviceSet.toList();
          deviceList.sort((a, b) => b.rssi.compareTo(a.rssi));
          notifyListeners();
        }
      });
    });
    _flutterBlue.isScanning.listen((event) {
      if (event) {
        isScanning = true;
        notifyListeners();
      } else {
        isScanning = false;
        notifyListeners();
      }
    });
  }
}
