import 'package:flutter/material.dart';

import 'package:flutter/gestures.dart';
import 'package:tabletop_gui/screens/board/board.dart';
import 'package:url_launcher/url_launcher.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  _launchURL() async {
    const url = 'https://gamerules.com/rules/twenty-nine-card-game/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 40.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            )),
                        Container(
                            child: Text(
                          "TABLETOP",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 30.0),
                        )),
                        Container(
                            child: Icon(
                          Icons.notifications,
                          color: Colors.white,
                        ))
                      ],
                    )),
                Text(
                  "Welcome To Twenty-Nine",
                  style: TextStyle(color: Colors.white, fontSize: 18.0),
                ),
                Padding(
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Divider(
                      thickness: 2,
                    )),
                Padding(
                    padding: EdgeInsets.only(bottom: 10.0),
                    child: RaisedButton(
                      child: Text(
                        "Find Public Game",
                        style: TextStyle(color: Colors.white, fontSize: 18.0),
                      ),
                      color: Color(0xff00B16A),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BoardScreen()));
                      },
                    )),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "40 Players Currently Online",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                RaisedButton(
                  child: Text(
                    "Create Private Game",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                  ),
                  color: Color(0xffEB5757),
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: RaisedButton(
                    child: Text(
                      "Join Private Game",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    color: Color(0xff2F80ED),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 275.0),
                  child: Text(
                    "19 Friends Currently Online",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Don't Know The Rules? ",
                      style: TextStyle(color: Colors.white, fontSize: 16.0),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Read The Rules Here',
                          style: TextStyle(color: Colors.red),
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              _launchURL();
                            },
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )));
  }
}
