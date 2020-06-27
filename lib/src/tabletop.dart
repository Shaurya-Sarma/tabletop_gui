import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:tabletop_gui/src/routes.dart';
import 'package:tabletop_gui/src/theme/style.dart';

class TabletopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Tabletop',
      theme: appTheme(),
      initialRoute: '/',
      routes: routes,
    );
  }
}
