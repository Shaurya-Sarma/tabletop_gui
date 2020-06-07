import 'package:tabletop_gui/src/blocs/base_bloc.dart';
import 'dart:async';

class TwentyNineBoardBloc extends BaseBloc {
  Future<Map<String, dynamic>> findGameData(String gameCode) {
    return repository.findGameData(gameCode);
  }

  void exitGame(String gameCode) {
    repository.exitGame(gameCode);
  }

  void dispose() {}
}
