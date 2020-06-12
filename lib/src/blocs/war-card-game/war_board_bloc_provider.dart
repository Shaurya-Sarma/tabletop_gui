import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_board_bloc.dart';

class WarBoardBlocProvider extends InheritedWidget {
  final bloc = WarBoardBloc();

  WarBoardBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static WarBoardBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(WarBoardBlocProvider)
            as WarBoardBlocProvider)
        .bloc;
  }
}
