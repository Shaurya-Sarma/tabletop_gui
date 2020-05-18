import 'package:flutter/material.dart';

class LoginWelcomeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 275,
        height: 55,
        child: RaisedButton(
          child: Text(
            "LOGIN",
            style: TextStyle(
                color: Color(0xff00B16A),
                fontWeight: FontWeight.w500,
                fontSize: 24.0),
          ),
          shape: StadiumBorder(),
          onPressed: () => Navigator.pushNamed(context, '/login'),
        ));
  }
}
