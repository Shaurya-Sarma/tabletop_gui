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
        Padding(padding: EdgeInsets.only(top: 30.0), child: userGreeting()),
        Padding(
          padding: EdgeInsets.only(top: 35.0),
          child: userProfileImage(),
        ),
      ],
    );
  }

  Widget userGreeting() {
    return Column(
      children: <Widget>[
        Text(
          "Hello!",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 40.0,
          ),
        ),
        Text(
          "${widget.user.displayName}",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 40.0,
          ),
        ),
      ],
    );
  }

  Widget userProfileImage() {
    return CircleAvatar(
      backgroundImage: NetworkImage("${widget.user.photoUrl}"),
      radius: 100,
    );
  }

  // Widget userExperience() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: <Widget>[
  //       Icon(
  //         Icons.offline_bolt,
  //         color: Color(0xff6FCF97),
  //         size: 100.0,
  //       ),
  //       Padding(
  //           padding: EdgeInsets.only(left: 10.0),
  //           child: Column(
  //             children: <Widget>[
  //               Text(
  //                 "LEVEL 3",
  //                 style: TextStyle(
  //                     color: Color(0xff6FCF97),
  //                     fontSize: 26.0,
  //                     fontWeight: FontWeight.w500),
  //               ),
  //             ],
  //           ))
  //     ],
  //   );
  // }
}
