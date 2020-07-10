import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/fifteen-puzzle-game/fifteen_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_lobby_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/fifteen-puzzle-game/fifteen_board.dart';
import 'package:tabletop_gui/src/screens/snake-game/snake-game_board.dart';
import 'package:tabletop_gui/src/screens/war-card-game/war_lobby.dart';

class GamesScreen extends StatefulWidget {
  @override
  _GamesScreenState createState() => _GamesScreenState();
}

class _GamesScreenState extends State<GamesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60.0, left: 30.0, bottom: 35.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Games",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0,
                    ),
                  ),
                ),
                GestureDetector(
                    child: _buildGameCard("arcade_icon.png", "Snake"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SnakeGameBlocProvider(
                                    child: SnakeGameBoard(),
                                  )));
                    }),
                GestureDetector(
                    child: _buildGameCard("cards_icon.png", "War"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WarLobbyBlocProvider(
                                    child: LobbyScreen(),
                                  )));
                    }),
                GestureDetector(
                    child: _buildGameCard("puzzle_icon.png", "Fifteen"),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FifteenBlocProvider(
                                    child: FifteenPuzzleBoard(),
                                  )));
                    }),
                SizedBox(height: 60)
              ],
            ),
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                height: 180,
                width: 180,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/blue_banner.png'),
                        fit: BoxFit.cover)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGameCard(String imageName, String gameTitle) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 35.0),
      padding: EdgeInsets.symmetric(vertical: 28.0, horizontal: 40.0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
                color: Color(0x64000000), blurRadius: 5.0, offset: Offset(1, 2))
          ]),
      child: Column(
        children: <Widget>[
          Image(
              image: AssetImage("assets/images/$imageName"),
              height: 150,
              width: 150),
          Container(
            margin: EdgeInsets.only(top: 15.0),
            child: Text(gameTitle,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0)),
          ),
        ],
      ),
    );
  }
}
