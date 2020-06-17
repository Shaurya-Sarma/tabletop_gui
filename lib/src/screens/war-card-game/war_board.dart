import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc_provider.dart';
import 'package:tabletop_gui/src/models/game.dart';

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
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      backArrow(),
                      joinCodeButton(),
                    ],
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      playerOne(),
                      Image(
                        image: AssetImage('assets/images/cards/back.png'),
                        height: 150,
                      )
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Image(
                          image: AssetImage('assets/images/cards/back.png'),
                          height: 150),
                      playerTwo()
                    ]),
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
}
