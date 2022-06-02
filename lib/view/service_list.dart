import 'package:flutter/material.dart';
import 'package:bocco_bluetooth_test/view_model/service_list_model.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:provider/provider.dart';

class ServiceList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)!.settings.arguments as ScanResult;

    return ChangeNotifierProvider(
      create: (context) => ServiceListModel(),
      builder: (context, _) {
        final model = Provider.of<ServiceListModel>(context, listen: false);
        final ScanResult result = arguments;
        model.connectDevice(result.device);
        return Scaffold(
          appBar: AppBar(
            title: Text('Service list'),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Selector<ServiceListModel, List<BluetoothService>>(
                  selector: (_, model) => model.serviceList,
                  builder: (_, list, __) {
                    return Column(
                      children: list
                          .map(
                            (service) => ListTile(
                              onTap: () {
                                Navigator.of(context).pushNamed(
                                    '/charcteristic_list',
                                    arguments: service.characteristics);
                              },
                              title: Text('${service.uuid}'),
                            ),
                          )
                          .toList(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
