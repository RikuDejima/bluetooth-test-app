import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/configs/bocco_data.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:bocco_bluetooth_test/encrypt/encrypt_bocco_v2.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:bocco_bluetooth_test/bocco/characteristics.dart';

class CharacterisicListModel with ChangeNotifier {
  late String readText;
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
}
