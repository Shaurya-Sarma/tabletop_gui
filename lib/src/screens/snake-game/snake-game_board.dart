import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc_provider.dart';

class SnakeGameBoard extends StatefulWidget {
  @override
  _SnakeGameBoardState createState() => _SnakeGameBoardState();
}

class _SnakeGameBoardState extends State<SnakeGameBoard> {
  SnakeGameBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = SnakeGameBlocProvider.of(context);
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  bool isGameActive = false;

  void gameManager() {
    _bloc.snakeCellPos = [197, 198, 199, 200];
    isGameActive = true;
    Timer.periodic(_bloc.tickSpeed, (timer) {
      updateSnakePos();
      if (_bloc.isGameOver()) {
        isGameActive = false;
        timer.cancel();
        _showEndDialog();
      }
    });
  }

  void updateSnakePos() {
    setState(() {
      _bloc.moveSnake();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green[900],
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails value) {
                  _bloc.switchSnakeHorizontalDirection(value);
                },
                onVerticalDragUpdate: (DragUpdateDetails value) {
                  _bloc.switchSnakeVerticalDirection(value);
                },
                child: GridView.builder(
                  itemCount: SnakeGameBloc.numOfTiles,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SnakeGameBloc.tilesPerRow),
                  itemBuilder: (BuildContext context, int index) {
                    if (_bloc.snakeCellPos.contains(index)) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Colors.blue,
                          ));
                    } else if (_bloc.foodPos == index) {
                      return ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            color: Colors.red,
                          ));
                    } else if (index % 2 == 0) {
                      return ClipRect(
                        child: Container(
                          color: Colors.green,
                        ),
                      );
                    } else {
                      return ClipRect(
                        child: Container(
                          color: Colors.green[400],
                        ),
                      );
                    }
                  },
                  physics: NeverScrollableScrollPhysics(),
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RaisedButton(
                    color: Colors.blueAccent,
                    child: Text(
                      "START",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      isGameActive ? null : gameManager();
                    }),
                RaisedButton(
                    color: Colors.redAccent,
                    child: Text("EXIT", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }

  _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text("Game Over!"),
          content: new Text("Your Score Was ${_bloc.snakeCellPos.length - 4}"),
          actions: <Widget>[
            FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
