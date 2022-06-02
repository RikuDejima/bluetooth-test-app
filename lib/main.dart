import 'package:bocco_bluetooth_test/view/characteristic_detail.dart';
import 'package:bocco_bluetooth_test/view/charcteristic_list.dart';
import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/view/device_list.dart';
import 'view/service_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: <String, WidgetBuilder>{
        '/service_list': (BuildContext context) => ServiceList(),
        '/charcteristic_list': (BuildContext context) => CharcteristicList(),
        '/charcteristic_detail': (BuildContext context) => CharcteristicDetail()
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: DeviceListScreen(),
    );
  }
}
