import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/fifteen-puzzle-game/fifteen_bloc.dart';

class FifteenBlocProvider extends InheritedWidget {
  final bloc = FifteenBloc();

  FifteenBlocProvider({Key key, Widget child}) : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static FifteenBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(FifteenBlocProvider)
            as FifteenBlocProvider)
        .bloc;
  }
}
