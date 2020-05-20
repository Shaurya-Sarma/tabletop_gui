import 'package:flutter/material.dart';
import 'package:tabletop_gui/screens/welcome/components/login_welcome_button.dart';
import 'package:tabletop_gui/screens/welcome/components/register_welcome_button.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/download.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Color(0xff00B16A).withOpacity(0.6),
                        BlendMode.srcATop))),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top: 225),
                    child: Text(
                      "TABLETOP",
                      style: TextStyle(
                          fontSize: 42.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
                Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: RegisterWelcomeBtn()),
                    Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: LoginWelcomeBtn())
                  ],
                )
              ],
            )));
  }
}
