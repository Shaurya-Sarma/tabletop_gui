import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_lobby_bloc.dart';

class TwentyNineLobbyBlocProvider extends InheritedWidget {
  final bloc = TwentyNineLobbyBloc();

  TwentyNineLobbyBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static TwentyNineLobbyBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TwentyNineLobbyBlocProvider)
            as TwentyNineLobbyBlocProvider)
        .bloc;
  }
}
