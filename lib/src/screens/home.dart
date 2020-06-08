import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/models/user.dart';
import 'package:tabletop_gui/src/screens/widgets/logo.dart';

import 'package:tabletop_gui/src/screens/games.dart';
import 'package:tabletop_gui/src/screens/profile.dart';
import 'package:tabletop_gui/src/screens/social.dart';
import 'package:tabletop_gui/src/screens/user_settings.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  const HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Widget> _children() => <Widget>[
        ProfileScreen(user: widget.user),
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
    final List<Widget> children = _children();

    return Scaffold(
      body: Padding(
          padding: EdgeInsets.only(top: 30.0),
          child: ListView(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  alignment: Alignment.center,
                  child: TabletopLogo()),
              children[_selectedIndex]
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
