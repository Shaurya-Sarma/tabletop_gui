import 'package:flutter/material.dart';

import 'package:flutter/services.dart';

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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
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
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
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
