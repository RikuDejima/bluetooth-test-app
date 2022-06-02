import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/view_model/characteristic_detail_model.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class CharcteristicDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as BluetoothCharacteristic;

    return ChangeNotifierProvider(
      create: (context) => CharacterisicDetailModel(),
      builder: (context, _) {
        final model =
            Provider.of<CharacterisicDetailModel>(context, listen: false);
        final BluetoothCharacteristic char = arguments;
        model.char = arguments;
        model.getReadOrWrite(char);
        return Scaffold(
          appBar: AppBar(
            title: Text('Characteristic list'),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Card(
                    margin: EdgeInsets.all(5),
                    elevation: 3,
                    child: Column(
                      children: [
                        Center(
                          child: ElevatedButton(
                            child:
                                model.ableWrite ? Text('write') : Text('read'),
                            onPressed:
                                model.ableWrite ? model.write : model.read,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    child: Column(
                      children: [
                        Text('status'),
                      ],
                    ),
                    elevation: 3,
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
