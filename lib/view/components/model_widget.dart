// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// abstract class ModelWidget<T extends ChangeNotifier> extends StatelessWidget {
//   final bool _modelListen;
//   ModelWidget()
//   T createModel(BuildContext context);
//   Widget buildWidthModel(BuildContext context, T model);

//   @override
//   Widget build(BuildContext context) => ChangeNotifierProvider(
//     create: (_) => createModel(context),
//     builder: (context, child) => buildWidthModel(context, Provider.of<T>(context, listen: false)),
//   );
// }
