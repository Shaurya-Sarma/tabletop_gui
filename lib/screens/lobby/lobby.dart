import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';

import 'package:tabletop_gui/screens/board/board.dart';

import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  void _launchURL() async {
    const url = 'https://gamerules.com/rules/twenty-nine-card-game/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _createPrivate() async {
    String gameCode = UniqueKey().toString();

    final FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection("games").add({
      'uuid': '$gameCode',
      'type': 'twenty-nine',
      'players': ['${currentUser.uid}'],
      'game': {
        'score': 0,
        'teamOne': ["", ""],
        'teamTwo': ["", ""],
      }
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BoardScreen(gameCode: gameCode)));
  }

  void _joinPrivate() async {
    QuerySnapshot gameInstance = await Firestore.instance
        .collection("games")
        .where("uuid", isEqualTo: "${_textFieldController.text}")
        .getDocuments();

    gameInstance.documents.forEach((doc) async {
      DocumentSnapshot document = await doc.reference.get();
      List<dynamic> players = document.data['players'];
      final FirebaseUser currentUser =
          await FirebaseAuth.instance.currentUser();
      players.add('${currentUser.uid}');
      doc.reference.updateData({
        'players': players,
      });
    });

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                BoardScreen(gameCode: _textFieldController.text)));
  }

  TextEditingController _textFieldController = TextEditingController();

  void _openDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Join Private Game'),
          content: TextField(
            controller: _textFieldController,
            decoration: InputDecoration(hintText: "Enter A Game Code"),
            keyboardType: TextInputType.text,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('JOIN', style: TextStyle(color: Colors.green)),
              onPressed: () {
                _joinPrivate();
              },
            )
          ],
        );
      },
    );
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
                      onPressed: () {},
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
                  onPressed: () {
                    _createPrivate();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: RaisedButton(
                    child: Text(
                      "Join Private Game",
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                    color: Color(0xff2F80ED),
                    onPressed: () {
                      _openDialog();
                    },
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
