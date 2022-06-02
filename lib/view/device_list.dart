import 'package:bocco_bluetooth_test/view/service_list.dart';
import 'package:bocco_bluetooth_test/logic/view_model/device_list_model.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:loader_overlay/loader_overlay.dart';

class DeviceListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => DeviceListModel(),
        builder: (context, __) {
          final model = Provider.of<DeviceListModel>(context, listen: false);
          model.addDeviceData();
          return Scaffold(
            appBar: AppBar(
              title: Text('Device list'),
            ),
            body: LoaderOverlay(
              child: Selector<DeviceListModel, bool>(
                selector: (_, model) => model.isScanning,
                builder: (_, isScanning, __) {
                  print('$isScanning:inselector');
                  model.isScanning == true
                      ? context.loaderOverlay.show()
                      : context.loaderOverlay.hide();
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        Selector<DeviceListModel, List<ScanResult>>(
                          selector: (_, model) => model.deviceList,
                          builder: (_, list, __) {
                            return Column(
                              children: list
                                  .map(
                                    (result) => ListTile(
                                      onTap: () => Navigator.of(context)
                                          .pushNamed('/service_list', arguments: result),
                                      title: Text(
                                          "${result.device.name} ${result.advertisementData.serviceUuids}"),
                                      subtitle: Text("${result.rssi}"),
                                    ),
                                  )
                                  .toList(),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () => model.addDeviceData(),
              child: Icon(Icons.refresh),
            ),
          );
        });
  }
}
