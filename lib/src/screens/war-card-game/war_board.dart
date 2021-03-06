import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc_provider.dart';
import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/playing_card.dart';
import 'package:tabletop_gui/src/models/user.dart';
import 'package:tabletop_gui/src/models/war_game.dart';
import 'package:tabletop_gui/src/utils/toast_utils.dart';
import 'package:tabletop_gui/src/utils/strings.dart';
import 'package:tabletop_gui/src/utils/audio_manager.dart';

class BoardScreen extends StatefulWidget {
  final String gameCode;
  BoardScreen({this.gameCode});

  @override
  _BoardScreenState createState() => _BoardScreenState(gameCode);
}

class _BoardScreenState extends State<BoardScreen> {
  String gameCode;
  _BoardScreenState(this.gameCode);
  User _user;

  WarBoardBloc _bloc;
  Map<String, String> playerOneCardImage = {'suit': "empty", 'rank': "empty"};
  Map<String, String> playerTwoCardImage = {'suit': "empty", 'rank': "empty"};

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WarBoardBlocProvider.of(context);
    _bloc.listenForChanges(gameCode);
    _bloc.currentUser().listen((event) {
      _user = event;
    });

    _bloc.currentGame().listen((game) {
      WarGame wg = game.game as WarGame;
      checkWinner(wg, game);
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
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
                  child: StreamBuilder<Object>(
                      stream: _bloc.currentGame(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          Game game = snapshot.data;
                          int index = game.players.indexWhere(
                              (element) => element["email"] == _user.email);
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              playerOneSide(index == 0 ? 1 : 0),
                              playerBoard(),
                              playerTwoSide(index),
                            ],
                          );
                        } else {
                          return Text("Loading...",
                              style: TextStyle(color: Colors.white));
                        }
                      }),
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
    return StreamBuilder(
        stream: _bloc.currentGame(),
        builder: (context, snapshot) {
          Game game = snapshot.data;
          if (snapshot.hasData) {
            return IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              iconSize: 30.0,
              onPressed: () async {
                _bloc.endGame(game);
                _bloc.exitGame(gameCode);
                Navigator.pop(context);
              },
            );
          } else {
            return Container();
          }
        });
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

  Widget playerOneSide(int index) {
    return StreamBuilder(
        stream: _bloc.currentGame(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Game game = snapshot.data;
            WarGame wg = game.game as WarGame;
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  playerOne(index),
                  GestureDetector(
                    child: Image(
                        image: AssetImage(
                            'assets/images/cards/empty_of_empty.png'),
                        height: 150),
                    onTap: () {
                      cardOnTap(wg, game, index);
                    },
                  ),
                ]);
          } else {
            return Container();
          }
        });
  }

  Widget playerOne(int index) {
    return StreamBuilder(
      stream: _bloc.currentGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.players.length == 2) {
          Game game = snapshot.data;
          WarGame wg = game.game as WarGame;
          bool myTurn = index == 0
              ? wg != null && wg.playerOneTurn != null && wg.playerOneTurn
              : wg != null && wg.playerOneTurn != null && !wg.playerOneTurn;
          List<PlayingCard> myDeck =
              index == 0 ? wg.playerOneDeck : wg.playerTwoDeck;
          return Column(
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    NetworkImage('${game.players[index]["photoUrl"]}'),
                radius: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "${game.players[index]["displayName"]}",
                  style: TextStyle(
                      color: myTurn ? Colors.yellow[600] : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              ),
              Visibility(
                visible: wg != null && wg.active != null ? wg.active : false,
                child: Text(
                  "${myDeck != null ? myDeck.length : ""} Cards Left",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 24.0,
                      color: Colors.white),
                ),
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
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              )
            ],
          );
        }
      },
    );
  }

  Widget playerTwoSide(int index) {
    return StreamBuilder(
        stream: _bloc.currentGame(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Game game = snapshot.data;
            WarGame wg = game.game as WarGame;
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  GestureDetector(
                    child: Image(
                        image: AssetImage(
                            'assets/images/cards/empty_of_empty.png'),
                        height: 150),
                    onTap: () {
                      cardOnTap(wg, game, index);
                    },
                  ),
                  playerTwo(index)
                ]);
          } else {
            return Container();
          }
        });
  }

  void cardOnTap(WarGame wg, Game game, int playerNumber) {
    bool myTurn = playerNumber == 0 && wg.playerOneTurn ||
        playerNumber == 1 && !wg.playerOneTurn;
    if (myTurn && _user.email == game.players[playerNumber]["email"]) {
      AudioManager.playSound("playcard.mp3", 1.2);
      _bloc.playerMove(playerNumber, game);
    }
  }

  Widget playerTwo(int index) {
    return StreamBuilder(
      stream: _bloc.currentGame(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data.players.length >= 1) {
          Game game = snapshot.data;
          WarGame wg = game.game as WarGame;
          bool myTurn = index == 0
              ? wg != null && wg.playerOneTurn != null && wg.playerOneTurn
              : wg != null && wg.playerOneTurn != null && !wg.playerOneTurn;
          List<PlayingCard> myDeck =
              index == 0 ? wg.playerOneDeck : wg.playerTwoDeck;
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              CircleAvatar(
                backgroundImage:
                    NetworkImage('${game.players[index]["photoUrl"]}'),
                radius: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: Text(
                  "${game.players[index]["displayName"]}",
                  style: TextStyle(
                      color: myTurn ? Colors.yellow[600] : Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0),
                ),
              ),
              Visibility(
                visible: wg != null && wg.active != null ? wg.active : false,
                child: Text("${myDeck != null ? myDeck.length : ""} Cards Left",
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 24.0,
                        color: Colors.white)),
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
                child: Text("Invite A Player",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    )),
              )
            ],
          );
        }
      },
    );
  }

  Widget playerBoard() {
    return StreamBuilder(
        stream: _bloc.currentGame(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            Game game = snapshot.data;
            WarGame wg = game.game as WarGame;
            String playerOneRank =
                wg.playerOneCard != null ? wg.playerOneCard.rank : "empty";
            String playerOneSuit =
                wg.playerOneCard != null ? wg.playerOneCard.suit : "empty";
            String playerTwoRank =
                wg.playerTwoCard != null ? wg.playerTwoCard.rank : "empty";
            String playerTwoSuit =
                wg.playerTwoCard != null ? wg.playerTwoCard.suit : "empty";
            return Column(
              children: <Widget>[
                Visibility(
                  visible: wg != null && wg.active != null ? !wg.active : true,
                  child: RaisedButton(
                    child: Text(
                      "Start",
                    ),
                    onPressed: () {
                      if (game.players.length == 2) {
                        AudioManager.playSound("shuffle.mp3", 1.2);
                        _bloc.initGame();
                      } else {
                        showErrorMessage(context);
                      }
                    },
                  ),
                ),
                Visibility(
                  visible: wg != null && wg.active != null ? wg.active : false,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      playerTwoRank != "empty"
                          ? Image(
                              image: AssetImage(
                                  'assets/images/cards/${playerTwoRank}_of_$playerTwoSuit.png'),
                              height: 150)
                          : Container(),
                      playerOneRank != "empty"
                          ? Image(
                              image: AssetImage(
                                  'assets/images/cards/${playerOneRank}_of_$playerOneSuit.png'),
                              height: 150)
                          : Container(),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Text(
              "Loading Board. Please Wait...",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            );
          }
        });
  }

  void checkWinner(WarGame wg, Game game) {
    if (wg != null && wg.turnCounter == 2) {
      _bloc.calculateWinner(game);
      wg != null && wg.winner != null && wg.winner >= 0
          ? ToastUtils.showToast(context,
              "${game.players[wg.winner]["displayName"]} wins!", Colors.red)
          : ToastUtils.showToast(context, "Tiebreaker Round!", Colors.blue);
      int gameWinner = _bloc.checkGameOver(game, wg);
      if (gameWinner >= 0) {
        AudioManager.playSound("game_win.mp3", 1.2);
        _showEndScreen(gameWinner);
      }
    }
  }

  void _showEndScreen(int playerNumber) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StreamBuilder(
            stream: _bloc.currentGame(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Game game = snapshot.data;
                return AlertDialog(
                  title: Text("Game Over!"),
                  content: playerNumber >= 0
                      ? Text(
                          "${game.players[playerNumber]["displayName"]} has won the game. Play Again?")
                      : Text("It was a tie game. Play Again?"),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Close"),
                      onPressed: () {
                        _bloc.endGame(game);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              } else {
                return Container();
              }
            });
      },
    );
  }

  void showErrorMessage(BuildContext context) {
    final snackbar = SnackBar(
        content: Text(StringConstant.warStartErrorMessage),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
