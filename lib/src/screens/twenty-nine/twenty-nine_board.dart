import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BoardScreen extends StatefulWidget {
  final String gameCode;
  BoardScreen({this.gameCode});

  @override
  _BoardScreenState createState() => _BoardScreenState(gameCode);
}

class _BoardScreenState extends State<BoardScreen> {
  String gameCode;
  _BoardScreenState(this.gameCode);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/images/Felt.png'),
            fit: BoxFit.cover,
          )),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.close),
                      color: Colors.white,
                      iconSize: 36.0,
                      onPressed: () async {
                        Navigator.pop(context);
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.portraitUp,
                          DeviceOrientation.portraitDown,
                        ]);

                        QuerySnapshot gameInstance = await Firestore.instance
                            .collection("games")
                            .where("uuid", isEqualTo: "$gameCode")
                            .getDocuments();

                        gameInstance.documents.forEach((doc) async {
                          DocumentSnapshot document = await doc.reference.get();
                          List<dynamic> players = document.data['players'];
                          final FirebaseUser currentUser =
                              await FirebaseAuth.instance.currentUser();
                          players.remove(currentUser.uid);
                          doc.reference.updateData({
                            'players': players,
                          });
                        });
                      },
                    ),
                    OutlineButton(
                      child: Text("JOIN CODE",
                          style: TextStyle(color: Colors.white)),
                      borderSide: BorderSide(color: Colors.white),
                      onPressed: () {
                        _openDialog();
                      },
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(Icons.account_circle),
                  color: Colors.white,
                  iconSize: 60.0,
                  onPressed: () {},
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        color: Colors.white,
                        iconSize: 60.0,
                        onPressed: () {
                          // FirebaseDatabase.instance.reference().child("users");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        color: Colors.white,
                        iconSize: 60.0,
                        onPressed: () {
                          // FirebaseDatabase.instance.reference().child("users");
                        },
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.account_circle,
                  color: Colors.white,
                  size: 60.0,
                )
              ],
            ),
          )),
    );
  }

  void _openDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ROOM INVITE CODE'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text('Invite your friends to the game by sharing this code!'),
                Container(
                    padding: EdgeInsets.only(top: 40.0),
                    alignment: Alignment.center,
                    child: Text(
                      '$gameCode',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 36.0),
                    )),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('CLOSE'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
