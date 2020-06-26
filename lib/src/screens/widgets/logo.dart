import 'package:flutter/material.dart';

class TabletopLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 35.0),
      child: Image.asset(
        "assets/images/tabletop_logo.png",
        height: 60,
      ),
    );
  }
}
