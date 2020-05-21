import 'package:flutter/material.dart';

import 'package:tabletop_gui/main.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' show json, base64, ascii;

class HomeScreen extends StatelessWidget {
  final String jwt;
  final Map<String, dynamic> payload;

  HomeScreen(this.jwt, this.payload);

  factory HomeScreen.fromBase64(String jwt) => HomeScreen(
      jwt,
      json.decode(
          ascii.decode(base64.decode(base64.normalize(jwt.split(".")[1])))));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future:
                http.read('$SERVER_IP/api', headers: {"Authorization": jwt}),
            builder: (context, snapshot) => snapshot.hasData
                ? Column(
                    children: <Widget>[
                      Text("${payload['username']}, here's the data:"),
                      Text(snapshot.data,
                          style: Theme.of(context).textTheme.headline4)
                    ],
                  )
                : snapshot.hasError
                    ? Text("An error occurred")
                    : CircularProgressIndicator()),
      ),
    );
  }
}
