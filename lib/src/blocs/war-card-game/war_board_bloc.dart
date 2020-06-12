import 'package:tabletop_gui/src/blocs/base_bloc.dart';

class WarBoardBloc extends BaseBloc {
  findGameData(String gameCode) {
    final gameData = repository.findGameData(gameCode);
    return gameData;
  }

  void exitGame(String gameCode) {
    repository.exitGame(gameCode);
  }

  void dispose() {}
}
