import 'package:flutter/material.dart';

class TabletopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      child: Text(
        "TABLETOP",
        style: TextStyle(
            fontSize: 42.0, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
