import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<DocumentSnapshot> getUserData() async {
    FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();
    Future<DocumentSnapshot> data =
        Firestore.instance.collection("users").document(firebaseUser.uid).get();

    return data;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
        future: getUserData(), builder: _buildContext);
  }

  Widget _buildContext(
      BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return Center(child: Text('Please wait its loading...'));
    }

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
                          text: "${snapshot.data['displayName']}",
                          style: TextStyle(color: Color(0xff2F80ED)),
                        ),
                      ]),
                )),
            Padding(
              padding: EdgeInsets.only(top: 35.0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(snapshot.data['photoUrl']),
                radius: 100,
              ),
            ),
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
