import 'package:flutter/material.dart';
import 'package:tabletop_gui/screens/home/home.dart';
import 'package:tabletop_gui/screens/login/login.dart';
import 'package:tabletop_gui/screens/welcome/welcome.dart';

import 'package:tabletop_gui/theme/style.dart';
import 'package:tabletop_gui/routes.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert' show json, base64, ascii;

const SERVER_IP = 'http://schoolie-api.herokuapp.com';
final storage = FlutterSecureStorage();

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Future<String> get jwtOrEmpty async {
    var jwt = await storage.read(key: "jwt");
    if (jwt == null) return "";
    return jwt;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabletop',
      theme: appTheme(),
      routes: routes,
      home: FutureBuilder(
          future: jwtOrEmpty,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            if (snapshot.data != "") {
              var str = snapshot.data;
              var jwt = str.split(".");

              if (jwt.length != 3) {
                return LoginScreen();
              } else {
                var payload = json.decode(
                    ascii.decode(base64.decode(base64.normalize(jwt[1]))));
                if (DateTime.fromMillisecondsSinceEpoch(payload["exp"] * 1000)
                    .isAfter(DateTime.now())) {
                  return HomeScreen(str, payload);
                } else {
                  return LoginScreen();
                }
              }
            } else {
              return WelcomeScreen();
            }
          }),
    );
  }
}
