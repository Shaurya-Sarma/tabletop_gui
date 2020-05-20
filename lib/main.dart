import 'package:flutter/material.dart';

import 'package:tabletop_gui/theme/style.dart';
import 'package:tabletop_gui/routes.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

const SERVER_IP = 'http://192.168.1.167:5000';
final storage = FlutterSecureStorage();

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
