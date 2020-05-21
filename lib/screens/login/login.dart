import 'package:flutter/material.dart';
import 'package:tabletop_gui/screens/login/components/login_form.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 70.0, bottom: 40.0),
                child: Text(
                  "TABLETOP",
                  style: TextStyle(
                      fontSize: 46.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 40.0),
                child: LoginForm(),
              )
            ],
          )),
    );
  }
}
