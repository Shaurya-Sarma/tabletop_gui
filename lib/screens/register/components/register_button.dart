import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: 50,
        child: RaisedButton(
          color: Color(0xffEB5757),
          child: Text(
            "REGISTER",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 22.0),
          ),
          onPressed: () {
            print("Registering");
          },
        ));
  }
}
