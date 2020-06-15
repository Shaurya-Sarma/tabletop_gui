import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/fifteen-puzzle-game/fifteen_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_lobby_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/fifteen-puzzle-game/fifteen_board.dart';
import 'package:tabletop_gui/src/screens/snake-game/snake-game_board.dart';
import 'package:tabletop_gui/src/screens/war-card-game/war_lobby.dart';
import 'package:tabletop_gui/src/utils/strings.dart';

class GamesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          twentyNine(context),
          snakeGame(context),
          fifteenPuzzle(context)
        ],
      ),
    );
  }

  Widget twentyNine(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color(0xff212049),
        margin: EdgeInsets.symmetric(vertical: 30.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/war_thumbnail.jpg"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    StringConstant.warTitle,
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
          return WarLobbyBlocProvider(child: LobbyScreen());
        }));
      },
    );
  }

  Widget snakeGame(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color(0xff212049),
        margin: EdgeInsets.symmetric(vertical: 30.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/snake_game_thumbnail.png"),
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

  Widget fifteenPuzzle(BuildContext context) {
    return GestureDetector(
      child: Card(
        color: Color(0xff212049),
        margin: EdgeInsets.symmetric(vertical: 30.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/fifteen_puzzle_thumbnail.jpg"),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    StringConstant.fifteenPuzzleTitle,
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
          return FifteenBlocProvider(child: FifteenPuzzleBoard());
        }));
      },
    );
  }
}
