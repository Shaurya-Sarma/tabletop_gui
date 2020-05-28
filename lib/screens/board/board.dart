import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class BoardScreen extends StatefulWidget {
  @override
  _BoardScreenState createState() => _BoardScreenState();
}

class _BoardScreenState extends State<BoardScreen> {
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
                IconButton(
                  icon: Icon(Icons.account_circle),
                  color: Colors.white,
                  onPressed: () async {
                    QuerySnapshot querySnapshot = await Firestore.instance
                        .collection("users")
                        .getDocuments();
                    print(
                        "users collection: ${querySnapshot.documents.elementAt(0).data}");
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        color: Colors.white,
                        onPressed: () {
                          // FirebaseDatabase.instance.reference().child("users");
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.account_circle),
                        color: Colors.white,
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
}
