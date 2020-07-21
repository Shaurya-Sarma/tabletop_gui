import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/sudoku-game/sudoku_bloc.dart';

class SudokuBlocProvider extends InheritedWidget {
  final bloc = SudokuBloc();

  SudokuBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static SudokuBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SudokuBlocProvider)
            as SudokuBlocProvider)
        .bloc;
  }
}
