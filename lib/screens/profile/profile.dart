import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          children: <Widget>[
            Padding(
                padding: EdgeInsets.only(top: 70.0),
                child: RichText(
                  text: TextSpan(
                      text: "Hello, ",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 40.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: "Username",
                          style: TextStyle(color: Color(0xff2F80ED)),
                        ),
                      ]),
                )),
            Padding(
                padding: EdgeInsets.only(top: 35.0),
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 250.0,
                )),
            Padding(
                padding: EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.offline_bolt,
                      color: Color(0xff6FCF97),
                      size: 100.0,
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 10.0),
                        child: Column(
                          children: <Widget>[
                            Text(
                              "LEVEL 3",
                              style: TextStyle(
                                  color: Color(0xff6FCF97),
                                  fontSize: 26.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ))
                  ],
                )),
          ],
        ));
  }
}
