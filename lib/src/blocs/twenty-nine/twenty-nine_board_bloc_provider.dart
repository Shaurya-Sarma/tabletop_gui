import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/blocs/twenty-nine/twenty-nine_board_bloc.dart';

class TwentyNineBoardBlocProvider extends InheritedWidget {
  final bloc = TwentyNineBoardBloc();

  TwentyNineBoardBlocProvider({Key key, Widget child})
      : super(key: key, child: child);

  bool updateShouldNotify(_) => true;

  static TwentyNineBoardBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(TwentyNineBoardBlocProvider)
            as TwentyNineBoardBlocProvider)
        .bloc;
  }
}
