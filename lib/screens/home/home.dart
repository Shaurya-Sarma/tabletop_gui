import 'package:flutter/material.dart';

import 'package:tabletop_gui/screens/profile/profile.dart';
import 'package:tabletop_gui/screens/games/games.dart';
import 'package:tabletop_gui/screens/social/social.dart';
import 'package:tabletop_gui/screens/user_settings/user_settings.dart';

import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key, @required this.user}) : super(key: key);
  final FirebaseUser user;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    ProfileScreen(),
    GamesScreen(),
    SocialScreen(),
    SettingsScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  new Spacer(),
                  Padding(
                      padding: EdgeInsets.only(left: 40.0),
                      child: Text(
                        "TABLETOP",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30.0),
                      )),
                  new Spacer(),
                  Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ))
                ],
              ),
              _widgetOptions.elementAt(_selectedIndex)
            ],
          )),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), title: Text("Profile")),
          BottomNavigationBarItem(
              icon: Icon(Icons.gamepad), title: Text("Games")),
          BottomNavigationBarItem(
              icon: Icon(Icons.people), title: Text("Social")),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), title: Text("Settings")),
        ],
        currentIndex: _selectedIndex,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
