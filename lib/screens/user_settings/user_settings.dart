import 'package:flutter/material.dart';

import 'package:tabletop_gui/screens/login/login.dart';

import 'package:firebase_auth/firebase_auth.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Future<void> userLogout() async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Color(0xffEB5757),
        child: Text(
          "LOGOUT",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22.0),
        ),
        onPressed: () {
          userLogout();
        },
      ),
    );
  }
}
