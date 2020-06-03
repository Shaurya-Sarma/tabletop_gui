import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_lobby_bloc.dart';

import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_lobby_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/twenty-nine/twenty-nine_board.dart';
import 'package:tabletop_gui/src/screens/widgets/logo.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  TwentyNineLobbyBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = TwentyNineLobbyBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(bottom: 40.0), child: appHeader()),
                appGameTitle(),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: publicGameButton(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    "40 Players Currently Online",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                createPrivateGameButton(),
                Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: joinPrivateGameButton(),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 200.0),
                  child: Text(
                    "19 Friends Currently Online",
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                ),
                Center(
                  child: gameRulesLink(),
                )
              ],
            )));
  }

  Widget appHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        Container(child: TabletopLogo()),
        Container(
            child: Icon(
          Icons.notifications,
          color: Colors.white,
        ))
      ],
    );
  }

  Widget appGameTitle() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            "Welcome To Twenty-Nine",
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: Divider(
                thickness: 2,
              )),
        ]);
  }

  Widget publicGameButton() {
    return RaisedButton(
      child: Text(
        "Find Public Game",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      color: Color(0xff00B16A),
      onPressed: () {},
    );
  }

  Widget createPrivateGameButton() {
    return RaisedButton(
      child: Text(
        "Create Private Game",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      color: Color(0xffEB5757),
      onPressed: () {
        _bloc.createPrivateGame();
        _bloc.userJoinCode.listen((event) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BoardScreen(gameCode: event)));
        });
      },
    );
  }

  Widget joinPrivateGameButton() {
    return RaisedButton(
      child: Text(
        "Join Private Game",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
      ),
      color: Color(0xff2F80ED),
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Join Private Game'),
              content: StreamBuilder(
                  stream: _bloc.userJoinCode,
                  builder: (context, snapshot) {
                    return TextField(
                      decoration:
                          InputDecoration(hintText: "Enter A Game Code"),
                      onChanged: _bloc.changeUserJoinCode,
                      keyboardType: TextInputType.text,
                    );
                  }),
              actions: <Widget>[
                FlatButton(
                  child:
                      Text('CANCEL', style: TextStyle(color: Colors.redAccent)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                FlatButton(
                  child: Text('JOIN', style: TextStyle(color: Colors.green)),
                  onPressed: () {
                    _bloc.joinPrivateGame();
                    _bloc.userJoinCode.listen((event) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  BoardScreen(gameCode: event)));
                    });
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  Widget gameRulesLink() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Don't Know The Rules? ",
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        children: <TextSpan>[
          TextSpan(
            text: 'Read The Rules Here',
            style: TextStyle(color: Colors.red),
            recognizer: new TapGestureRecognizer()
              ..onTap = () {
                _bloc.launchURL();
              },
          ),
        ],
      ),
    );
  }
}
