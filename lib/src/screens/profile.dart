import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/models/user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(padding: EdgeInsets.only(top: 70.0), child: userGreeting()),
        Padding(
          padding: EdgeInsets.only(top: 35.0),
          child: userProfileImage(),
        ),
        Padding(padding: EdgeInsets.only(top: 30.0), child: userExperience()),
      ],
    );
  }

  Widget userGreeting() {
    return RichText(
      text: TextSpan(
          text: "Hello, ",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 40.0),
          children: <TextSpan>[
            TextSpan(
              text: "${widget.user.displayName}",
              style: TextStyle(color: Color(0xff2F80ED)),
            ),
          ]),
    );
  }

  Widget userProfileImage() {
    return CircleAvatar(
      backgroundImage: NetworkImage(widget.user.photoUrl),
      radius: 100,
    );
  }

  Widget userExperience() {
    return Row(
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
    );
  }
}
