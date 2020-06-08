import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_lobby_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/snake-game/snake-game_board.dart';
import 'package:tabletop_gui/src/screens/twenty-nine/twenty-nine_lobby.dart';
import 'package:tabletop_gui/src/utils/strings.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[twentyNine(context), snakeGame(context)],
    );
  }

  Widget twentyNine(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color(0xff212049),
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 50.0),
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
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TwentyNineLobbyBlocProvider(child: LobbyScreen());
        }));
      },
    );
  }

  Widget snakeGame(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    StringConstant.snakeGameTitle,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SnakeGameBlocProvider(child: SnakeGameBoard());
        }));
      },
    );
  }
}
