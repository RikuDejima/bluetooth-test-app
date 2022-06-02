import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/configs/bocco_data.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bocco_bluetooth_test/bocco/characteristics.dart';
import 'package:bocco_bluetooth_test/encrypt/encrypt_bocco_v2.dart';
import 'dart:convert';
import 'dart:typed_data';

class CharacterisicDetailModel with ChangeNotifier {
  late BluetoothCharacteristic char;
  late String readText;
  late String writeText;
  late bool ableWrite;

  void getReadOrWrite(BluetoothCharacteristic char) async {
    final settingCharacteristicUuids = BoccoId().settingCharacteristicUuids;
    //firstwhereとmap使ってkeyを特定し、readかwriteかを確定し、characteristic()にわたす
    print('トライ！');
    if (!settingCharacteristicUuids.containsKey(char.uuid)) return;
    print('突破');
    final key =
        settingCharacteristicUuids.keys.firstWhere((key) => key == char.uuid);
    // final characteristic = Charcteristic(char, s);
    print(settingCharacteristicUuids[key]!);
    ableWrite = settingCharacteristicUuids[key]!;
  }

  void read() async {
    if (char.serviceUuid == BoccoId().settingsServiceUuids[1]) {
      print('read中');
      List<int> value = await char.read();
      print('$value:value');
      String result = Utf8Decoder().convert(value);
      print('$result:result');
      readText = result;
      notifyListeners();
    } else {
      print('read中');
      List<int> value = await char.read();
      Uint8List decryptedData = BleEncryptBoccoV2(pin: '809622').decrypt(value);
      print(decryptedData);
      String result = Utf8Decoder().convert(decryptedData);
      print('$result:result');
      readText = result;
      notifyListeners(); //modelの変数にわたし、画面に映す
    }
  }

  void write() async {
    if (char.serviceUuid == BoccoId().settingsServiceUuids[1]) {
      Uint8List encryptedData = Utf8Encoder().convert(writeText);
      await char.write(encryptedData);
      print(encryptedData);
    } else {
      Uint8List encryptedData = Utf8Encoder().convert(writeText);
      Uint8List result =
          BleEncryptBoccoV2(pin: '809622').encrypt(encryptedData);
      await char.write(result);
    }
  }
}
