import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/fifteen-puzzle-game/fifteen_bloc.dart';
import 'package:tabletop_gui/src/blocs/fifteen-puzzle-game/fifteen_bloc_provider.dart';
import 'package:tabletop_gui/src/utils/audio_manager.dart';

class FifteenPuzzleBoard extends StatefulWidget {
  @override
  _FifteenPuzzleBoardState createState() => _FifteenPuzzleBoardState();
}

class _FifteenPuzzleBoardState extends State<FifteenPuzzleBoard> {
  FifteenBloc _bloc;
  bool isTimerActive = false;
  bool isGameOver = false;
  final Stopwatch _stopwatch = Stopwatch();
  final duration = Duration(milliseconds: 1);
  String timerDisplay = "00:00:00";
  int numberOfMoves = 0;

  void startStopwatch() {
    setState(() {
      isTimerActive = true;
    });
    _stopwatch.start();
    startTimer();
  }

  void startTimer() {
    Timer(duration, keeprunning);
  }

  void keeprunning() {
    if (_stopwatch.isRunning) {
      startTimer();
    }
    setState(() {
      timerDisplay =
          (_stopwatch.elapsed.inMinutes % 60).toString().padLeft(2, "0") +
              ":" +
              (_stopwatch.elapsed.inSeconds % 60).toString().padLeft(2, "0") +
              ":" +
              (_stopwatch.elapsedMilliseconds % 60).toString().padLeft(2, "0");
    });
  }

  void pauseStopwatch() {
    setState(() {
      isTimerActive = false;
    });
    _stopwatch.stop();
  }

  void resestGame() {
    _stopwatch.reset();
    timerDisplay = "00:00:00";
    numberOfMoves = 0;
  }

  void moveTile(int index) {
    if (isAdjacent(index)) {
      setState(() {
        int emptyTileIndex = _bloc.tileNumbers.indexOf(16);
        int clickedTileNumber = _bloc.tileNumbers[index];
        _bloc.tileNumbers[index] = 16;
        _bloc.tileNumbers[emptyTileIndex] = clickedTileNumber;
        // AudioManager.playSound("fifteen_tile_slide.mp3", 1.1);
        numberOfMoves += 1;
      });
      checkWin();
    }
  }

  bool isAdjacent(int index) {
    List<int> adjacentSquares = FifteenBloc.tileIndexPos[index];
    for (int i = 0; i < adjacentSquares.length; i++) {
      if (_bloc.tileNumbers[adjacentSquares[i]] == 16) {
        return true;
      }
    }
    return false;
  }

  void checkWin() {
    isGameOver = _bloc.tileNumbers.every((tile) {
      if (tile == _bloc.tileNumbers.indexOf(tile) + 1) {
        return true;
      } else {
        return false;
      }
    });
    if (isGameOver) {
      _showEndDialog();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = FifteenBlocProvider.of(context);
    _bloc.tileNumbers.shuffle();
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
        color: Colors.brown[100],
        padding: EdgeInsets.symmetric(
          horizontal: 40.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            backArrow(),
            timer(),
            gameBoard(),
            actionButtons(),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Text("$numberOfMoves Moves",
                  style:
                      TextStyle(fontWeight: FontWeight.w400, fontSize: 24.0)),
            )
          ],
        ),
      ),
    );
  }

  Widget backArrow() {
    return Container(
      alignment: Alignment.topLeft,
      padding: EdgeInsets.only(bottom: 30.0),
      child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 30.0,
          )),
    );
  }

  Widget timer() {
    return Text(
      "$timerDisplay",
      style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w800),
    );
  }

  Widget gameBoard() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Container(
              color: Color(0xFFa2917d),
              height: 400,
              child: GridView.builder(
                itemCount: FifteenBloc.numOfTiles,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: FifteenBloc.tilesPerRow),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: isTimerActive
                        ? () {
                            moveTile(index);
                          }
                        : null,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: numberTile(index),
                    ),
                  );
                },
              ))),
    );
  }

  Widget numberTile(int number) {
    if (_bloc.tileNumbers[number] == 16) {
      return Container();
    } else {
      return ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Container(
          color: _bloc.tileNumbers[number] == number + 1
              ? Colors.green[300]
              : Colors.brown[100],
          height: 400 / 4,
          child: Center(
            child: Text("${_bloc.tileNumbers[number]}",
                style: TextStyle(
                    fontSize: 24.0,
                    color: _bloc.tileNumbers[number] == number + 1
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w800)),
          ),
        ),
      );
    }
  }

  Widget actionButtons() {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.play_arrow),
            splashColor: Colors.green[400],
            iconSize: 30.0,
            onPressed: () {
              startStopwatch();
            }),
        IconButton(
            icon: Icon(Icons.pause),
            splashColor: Colors.red[600],
            iconSize: 30.0,
            onPressed: () {
              pauseStopwatch();
            }),
        RaisedButton(
          child: Text("New Puzzle", style: TextStyle(color: Colors.white)),
          color: Colors.amber[600],
          onPressed: () {
            setState(() {
              _bloc.tileNumbers.shuffle();
            });
            resestGame();
            pauseStopwatch();
          },
        )
      ],
    );
  }

  _showEndDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("You Have Solved The Puzzle!"),
          content: Text(
              "You solved it in ${_stopwatch.elapsed.inMinutes} minutes and ${_stopwatch.elapsed.inSeconds} seconds and in $numberOfMoves. "),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                resestGame();
              },
            ),
          ],
        );
      },
    );
    pauseStopwatch();
  }
}
