import 'package:flutter/material.dart';

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
      body: Container(
          child:
              Text("Hello, 'Username'", style: TextStyle(color: Colors.white))),
    );
  }
}
