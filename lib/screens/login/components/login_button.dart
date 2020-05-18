import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          color: Color(0xff00B16A),
          child: Text(
            "LOGIN",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22.0),
          ),
          onPressed: () {
            print("Logging In");
          },
        ));
  }
}
