import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/utils/strings.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        twentyNine(context),
      ],
    );
  }

  Widget twentyNine(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color(0xff212049),
        margin: EdgeInsets.all(40.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/twenty-nine.jpg"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    StringConstant.twentyNineTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Row(
                    children: <Widget>[
                      Text("29",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                          )),
                      Icon(
                        Icons.person,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, "/lobby");
      },
    );
  }
}
