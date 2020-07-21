import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/sudoku-game/sudoku_bloc.dart';
import 'package:tabletop_gui/src/blocs/sudoku-game/sudoku_bloc_provider.dart';

class SudokuBoard extends StatefulWidget {
  @override
  _SudokuBoardState createState() => _SudokuBoardState();
}

class _SudokuBoardState extends State<SudokuBoard> {
  SudokuBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = SudokuBlocProvider.of(context);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 30.0,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            backArrow(),
            appHeader(),
            gameBoard(),
            numberTiles(),
            actionButton(),
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
            // pauseStopwatch();
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 35.0,
          )),
    );
  }

  Widget appHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Container(
          child: FlatButton(
            onPressed: () {
              _bloc.generatePuzzle();
            },
            color: Colors.amber,
            child: Center(
              child: Text(
                "NEW GAME",
                style: TextStyle(
                    color: Colors.grey[100],
                    fontWeight: FontWeight.w500,
                    fontSize: 16.0),
              ),
            ),
          ),
        ),
        IconButton(
            icon: Icon(Icons.refresh, color: Colors.red),
            iconSize: 24.0,
            onPressed: null),
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  "Elasped Time",
                  style: TextStyle(color: Colors.red),
                ),
                Icon(
                  Icons.timer,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ],
    );
  }

  Widget gameBoard() {
    return Container(
      height: 450,
      child: GridView.builder(
          itemCount: SudokuBloc.gridSize,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int i) {
            return Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[900], width: 1.2),
                ), //             <--- BoxDecoration here
                child: GridView.builder(
                    itemCount: SudokuBloc.gridSize,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3),
                    itemBuilder: (BuildContext context, int j) {
                      return Container(
                        padding: EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[600], width: 1),
                        ),
                        child: Text(
                          "",
                        ),
                      );
                    }));
          }),
    );
  }

  Widget numberTiles() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        draggableTile("1"),
        draggableTile("2"),
        draggableTile("3"),
        draggableTile("4"),
        draggableTile("5"),
        draggableTile("6"),
        draggableTile("7"),
        draggableTile("8"),
        draggableTile("9"),
      ],
    );
  }

  Widget draggableTile(String text) {
    return Draggable(
        child: Container(
          child: Text(
            text,
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24.0),
          ),
        ),
        feedback: Container(
          padding: EdgeInsets.all(10.0),
          child: Text(
            text,
            style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
                color: Colors.blue[600]),
          ),
        ));
  }

  Widget actionButton() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 25.0),
      child: RaisedButton(
        onPressed: () {
          null;
        },
        padding: EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [Color(0xff636363), Color(0xffa2ab58)])),
          child: Center(
            child: Text(
              "SOLVE",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
