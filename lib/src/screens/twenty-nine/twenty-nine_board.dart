import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_board_bloc.dart';
import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_board_bloc_provider.dart';

class BoardScreen extends StatefulWidget {
  final String gameCode;
  BoardScreen({this.gameCode});

  @override
  _BoardScreenState createState() => _BoardScreenState(gameCode);
}

class _BoardScreenState extends State<BoardScreen> {
  String gameCode;
  
  _BoardScreenState(this.gameCode);

  TwentyNineBoardBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = TwentyNineBoardBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

    return Scaffold(
      body: Container(
          decoration: backgroundImage(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    backArrow(),
                    joinCodeButton(),
                  ],
                ),
                playerThree(),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      playerTwo(),
                      playerFour(),
                    ],
                  ),
                ),
                playerOne(),
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
      icon: Icon(Icons.arrow_back_ios),
      color: Colors.white,
      iconSize: 36.0,
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
    return CircleAvatar(
      backgroundImage: NetworkImage('${_bloc.findGameData(gameCode).}'),
      radius: 30,
    );
  }

  Widget playerTwo() {
    return IconButton(
      icon: Icon(Icons.account_circle),
      color: Colors.white,
      iconSize: 60.0,
      onPressed: () {
        _bloc
            .findGameData(gameCode)
            .then((value) => print('${value["players"][0]}'));
      },
    );
  }

  Widget playerThree() {
    return IconButton(
      icon: Icon(Icons.account_circle),
      color: Colors.white,
      iconSize: 60.0,
      onPressed: () {
      },
    );
  }

  Widget playerFour() {
    return IconButton(
      icon: Icon(Icons.account_circle),
      color: Colors.white,
      iconSize: 60.0,
      onPressed: () {},
    );
  }
}
