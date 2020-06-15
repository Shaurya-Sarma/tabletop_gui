import 'package:flutter/material.dart';
import 'package:flutter_timer/flutter_timer.dart';
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

  void moveTile(int index) {
    if (isAdjacent(index)) {
      setState(() {
        int emptyTileIndex = _bloc.tileNumbers.indexOf(16);
        int clickedTileNumber = _bloc.tileNumbers[index];
        _bloc.tileNumbers[index] = 16;
        _bloc.tileNumbers[emptyTileIndex] = clickedTileNumber;
        // AudioManager.playSound("fifteen_tile_slide.mp3", 1.1);
        checkWin();
      });
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
      if (tile == _bloc.tileNumbers.indexOf(tile) - 1) {
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // timer(),
            gameBoard(),
            actionButtons(),
          ],
        ),
      ),
    );
  }

  // Widget timer() {
  //   return TikTikTimer(
  //     height: 150,
  //     width: 150,
  //     initialDate: DateTime.now(),
  //     running: isTimerActive,
  //   );
  // }

  Widget gameBoard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
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
                    onTap: isGameOver
                        ? null
                        : () {
                            moveTile(index);
                          },
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
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        FlatButton(
          child: Text(
            "Start",
            style: TextStyle(color: Colors.green[600]),
          ),
          onPressed: () {
            setState(() {
              isTimerActive = true;
            });
          },
        ),
        FlatButton(
          child: Text(
            "Stop",
            style: TextStyle(color: Colors.red[600]),
          ),
          onPressed: () {
            setState(() {
              isTimerActive = false;
            });
          },
        ),
        RaisedButton(
          child: Text("New Puzzle +", style: TextStyle(color: Colors.white)),
          color: Colors.amber,
          onPressed: () {
            setState(() {
              _bloc.tileNumbers.shuffle();
            });
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
          content: Text("You solved it in _ minutes and _ seconds"),
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
}
