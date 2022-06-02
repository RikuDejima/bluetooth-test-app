import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/view_model/charcteristic_list_model.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class CharcteristicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments
        as List<BluetoothCharacteristic>;

    final List<BluetoothCharacteristic> characteristics = arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text('Characteristic list'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: characteristics
              .map(
                (char) => ListTile(
                  onTap: () {
                    // model.getReadOrWrite(char);
                    Navigator.of(context).pushNamed(
                      '/charcteristic_detail',
                      arguments: char,
                    );
                  },
                  title: Text('${char.uuid}'),
                ),
              )
              .toList(),
        ),
      ),
      bottomSheet: Container(
        height: 50,
        child: Text('bottomSheet'),
      ),
    );
  }
}
