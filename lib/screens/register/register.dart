import 'package:flutter/material.dart';

import 'package:tabletop_gui/screens/register/components/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            alignment: Alignment.center,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 90.0, bottom: 40.0),
                  alignment: Alignment.center,
                  child: Text(
                    "TABLETOP",
                    style: TextStyle(
                        fontSize: 46.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 80.0),
                    child: RegisterForm()),
              ],
            )));
  }
}
