import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/snake-game/snake-game_bloc.dart';

class SnakeGameBlocProvider extends InheritedWidget {
  final bloc = SnakeGameBloc();

  SnakeGameBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static SnakeGameBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(SnakeGameBlocProvider)
            as SnakeGameBlocProvider)
        .bloc;
  }
}
