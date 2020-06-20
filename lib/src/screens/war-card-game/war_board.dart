import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc_provider.dart';
import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/war_game.dart';

class BoardScreen extends StatefulWidget {
  final String gameCode;
  BoardScreen({this.gameCode});

  @override
  _BoardScreenState createState() => _BoardScreenState(gameCode);
}

class _BoardScreenState extends State<BoardScreen> {
  String gameCode;
  _BoardScreenState(this.gameCode);

  WarBoardBloc _bloc;
  bool isGameActive = false;
  bool playerOneTurn = true;
  WarGame wg = WarBoardBloc().getWarGame();
  Map<String, String> playerOneCardImage = {'suit': "empty", 'rank': "empty"};
  Map<String, String> playerTwoCardImage = {'suit': "empty", 'rank': "empty"};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WarBoardBlocProvider.of(context);
    _bloc.listenForChanges(gameCode);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  void gameManager() {
    _bloc.initGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: backgroundImage(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                header(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      playerOneSide(),
                      playerBoard(),
                      playerTwoSide(),
                    ],
                  ),
                ),
              ],
            ),
          )),
    );
  }

  BoxDecoration backgroundImage() {
    return BoxDecoration(
        image: DecorationImage(
      image: AssetImage('assets/images/Felt.png'),
      fit: BoxFit.cover,
    ));
  }

  Widget header() {
    return Container(
      margin: EdgeInsets.only(bottom: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          backArrow(),
          joinCodeButton(),
        ],
      ),
    );
  }

  Widget backArrow() {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      color: Colors.white,
      iconSize: 30.0,
      onPressed: () async {
        _bloc.exitGame(gameCode);
        Navigator.pop(context);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
      },
    );
  }

  Widget joinCodeButton() {
    return OutlineButton(
      child: Text("JOIN CODE", style: TextStyle(color: Colors.white)),
      borderSide: BorderSide(color: Colors.white),
      onPressed: () {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('ROOM INVITE CODE'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(
                        'Invite your friends to the game by sharing this code!'),
                    Container(
                        padding: EdgeInsets.only(top: 40.0),
                        alignment: Alignment.center,
                        child: Text(
                          '$gameCode',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 36.0),
                        )),
                  ],
                ),
              ),
              actions: [
                new FlatButton(
                  child: new Text('CLOSE'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget playerOneSide() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          playerOne(),
          GestureDetector(
            child: Image(
                image: AssetImage(
                    'assets/images/cards/${playerOneCardImage["rank"]}_of_${playerOneCardImage["suit"]}.png'),
                height: 150),
            onTap: () {
              if (playerOneTurn) {
                _bloc.playerMove(1);
                playerOneTurn = !playerOneTurn;
                setState(() {
                  playerOneCardImage["rank"] = wg.playerOneCard.rank;
                  playerOneCardImage["suit"] = wg.playerOneCard.suit;
                });
              }
            },
          ),
        ]);
  }

  Widget playerOne() {
    return StreamBuilder(
      stream: _bloc.currentGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          Game game = snapshot.data;
          print('game received ${game.players[0]}');
          return Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage('${game.players[0]["photoUrl"]}'),
                radius: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "${game.players[0]["displayName"]}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Visibility(
                visible: isGameActive,
                child: Text("Cards Remaining: ${wg.playerOneDeck.length}"),
              )
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 60,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Invite A Player",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget playerTwoSide() {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          GestureDetector(
            child: Image(
                image: AssetImage(
                    'assets/images/cards/${playerTwoCardImage["rank"]}_of_${playerTwoCardImage["suit"]}.png'),
                height: 150),
            onTap: () {
              if (!playerOneTurn) {
                _bloc.playerMove(2);
                playerOneTurn = !playerOneTurn;
                setState(() {
                  playerTwoCardImage["rank"] = wg.playerTwoCard.rank;
                  playerTwoCardImage["suit"] = wg.playerTwoCard.suit;
                });
              }
            },
          ),
          playerTwo()
        ]);
  }

  Widget playerTwo() {
    return StreamBuilder(
      stream: _bloc.currentGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.players.length == 2) {
          Game game = snapshot.data;
          print('game received ${game.players[1]}');
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: NetworkImage('${game.players[1]["photoUrl"]}'),
                radius: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "${game.players[1]["displayName"]}",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              ),
              Visibility(
                visible: isGameActive,
                child: Text("Cards Remaining: ${wg.playerTwoDeck.length}"),
              )
            ],
          );
        } else {
          return Column(
            children: <Widget>[
              Icon(
                Icons.account_circle,
                color: Colors.white,
                size: 60,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "Invite A Player",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget playerBoard() {
    return Column(
      children: <Widget>[
        Visibility(
          visible: !isGameActive,
          child: RaisedButton(
            child: Text(
              "Start",
            ),
            onPressed: () {
              setState(() {
                isGameActive = true;
              });
              gameManager();
            },
          ),
        ),
        Visibility(
          visible: isGameActive,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                  image: AssetImage('assets/images/cards/empty_of_empty.png'),
                  height: 150),
              Image(
                  image: AssetImage('assets/images/cards/empty_of_empty.png'),
                  height: 150),
            ],
          ),
        ),
      ],
    );
  }
}
