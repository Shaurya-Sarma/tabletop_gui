import 'package:flutter/material.dart';

import 'package:tabletop_gui/theme/style.dart';
import 'package:tabletop_gui/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabletop',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
