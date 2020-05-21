import 'package:flutter/material.dart';

class RegisterWelcomeBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 275,
        height: 55,
        child: OutlineButton(
          child: Text(
            "SIGN UP",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 24.0),
          ),
          borderSide: BorderSide(color: Colors.white),
          shape: StadiumBorder(),
          onPressed: () => Navigator.pushNamed(context, '/register'),
        ));
  }
}
