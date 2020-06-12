import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/war-card-game/war_lobby_bloc.dart';

class WarLobbyBlocProvider extends InheritedWidget {
  final bloc = WarLobbyBloc();

  WarLobbyBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static WarLobbyBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(WarLobbyBlocProvider)
            as WarLobbyBlocProvider)
        .bloc;
  }
}
