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
    return Scaffold(
        backgroundColor: Color(0xffF1F7FF),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(30.0, 55.0, 30.0, 70.0),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "My Profile",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 34.0,
                      ),
                    ),
                  ),
                  Container(
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("${widget.user.photoUrl}"),
                      radius: 85,
                    ),
                    margin: EdgeInsets.only(top: 60.0, bottom: 30.0),
                  ),
                  Text(
                    widget.user.displayName,
                    style:
                        TextStyle(fontWeight: FontWeight.w600, fontSize: 28.0),
                    softWrap: true,
                  )
                ],
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20.0),
                      bottomRight: Radius.circular(20.0)),
                  boxShadow: [
                    BoxShadow(
                        color: Color(0x23000000),
                        blurRadius: 15.0,
                        offset: Offset(0, 4))
                  ]),
            ),
            Container(
              height: 200,
              margin: EdgeInsets.only(top: 50.0),
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/profile_art.png"))),
            )
          ],
        ));
  }
}
