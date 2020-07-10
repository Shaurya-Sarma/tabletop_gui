import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc_provider.dart';
import 'package:tabletop_gui/src/utils/audio_manager.dart';

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
    super.dispose();
  }

  bool isGameActive = false;

  void gameManager() {
    _bloc.snakeCellPos = [
      [197, 'right'],
      [198, 'right'],
      [199, 'right'],
      [200, 'right']
    ];
    _bloc.snakeDirection = "right";
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
                    if (index % 2 == 0) {
                      return ClipRect(
                        child: Stack(
                          children: <Widget>[
                            Container(color: Colors.green),
                            addFruit(index),
                            addSnake(index),
                            addSpike(index),
                          ],
                        ),
                      );
                    } else {
                      return ClipRect(
                        child: Stack(
                          children: <Widget>[
                            Container(color: Colors.green[400]),
                            addFruit(index),
                            addSnake(index),
                            addSpike(index),
                          ],
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
                      if (!isGameActive) gameManager();
                    }),
                RaisedButton(
                    color: Colors.redAccent,
                    child: Text("EXIT", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      AudioManager.stopFile();
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
          title: Text("Game Over!"),
          content: Text("Your Score Was ${_bloc.snakeCellPos.length - 4}"),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget addFruit(int index) {
    if (_bloc.foodPos == index) {
      return Image(
        image: AssetImage("assets/images/apple_sprite.png"),
      );
    } else {
      return Container();
    }
  }

  Widget addSnake(int index) {
    if (_bloc.snakeCellPos.any((element) => element[0] == index)) {
      return ClipRRect(
          child: Container(
        color: Colors.orange[800],
      ));
    } else {
      return Container();
    }
  }

  Widget addSpike(int index) {
    if (_bloc.spikePos == index) {
      return Image(
        image: AssetImage("assets/images/spikeball_sprite.png"),
      );
    } else {
      return Container();
    }
  }
}
