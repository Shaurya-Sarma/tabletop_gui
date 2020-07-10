import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_lobby_bloc.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_lobby_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/war-card-game/war_board.dart';

class LobbyScreen extends StatefulWidget {
  @override
  _LobbyScreenState createState() => _LobbyScreenState();
}

class _LobbyScreenState extends State<LobbyScreen> {
  WarLobbyBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = WarLobbyBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        floatingActionButton: Padding(
          padding: EdgeInsets.all(16),
          child: FloatingActionButton(
            child: Icon(Icons.book),
            onPressed: () {
              _bloc.launchURL();
            },
            backgroundColor: Color(0xff0f0c29),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0),
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/war_background.png"),
                  fit: BoxFit.cover)),
          child: Stack(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Center(
                        child: Text(
                          "WAR",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w900,
                            fontSize: 42.0,
                          ),
                        ),
                      ),
                      Image(image: AssetImage("assets/images/war_logo.png")),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 30.0),
                    child: Image(
                      image: AssetImage("assets/images/war_art.png"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: RaisedButton(
                      onPressed: () {
                        joinGame();
                      },
                      padding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: buttonDecoration("JOIN GAME"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 15.0),
                    child: RaisedButton(
                      onPressed: () {
                        createGame();
                      },
                      padding: EdgeInsets.all(0.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: buttonDecoration("CREATE GAME"),
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                top: 50,
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 35.0,
                  ),
                  onTap: () => Navigator.pop(context),
                ),
              )
            ],
          ),
        ));
  }

  Widget buttonDecoration(String buttonText) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(colors: [
            Color(0xff0f0c29),
            Color(0xff302b63),
            Color(0xff0f0c29)
          ])),
      child: Center(
        child: Text(
          buttonText,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16.0),
        ),
      ),
    );
  }

  void createGame() {
    _bloc.createPrivateGame().then((value) =>
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return WarBoardBlocProvider(
              child: BoardScreen(
            gameCode: value,
          ));
        })));
  }

  void joinGame() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Join Private Game'),
          content: StreamBuilder(
              stream: _bloc.userJoinCode,
              builder: (context, snapshot) {
                return TextField(
                  decoration: InputDecoration(
                      hintText: "Enter A Game Code", errorText: snapshot.error),
                  onChanged: _bloc.changeUserJoinCode,
                  keyboardType: TextInputType.text,
                );
              }),
          actions: <Widget>[
            FlatButton(
              child: Text('CANCEL', style: TextStyle(color: Colors.redAccent)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text('JOIN', style: TextStyle(color: Colors.green)),
              onPressed: () {
                _bloc.joinPrivateGame().then((value) => {
                      if (value == "false")
                        {print("Error Joining")}
                      else
                        {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return WarBoardBlocProvider(
                                child: BoardScreen(
                              gameCode: value,
                            ));
                          }))
                        }
                    });
              },
            )
          ],
        );
      },
    );
  }
}
