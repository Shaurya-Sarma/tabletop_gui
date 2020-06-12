import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/user.dart';
import 'package:tabletop_gui/src/resources/repository.dart';

class BaseBloc {
  final _repository = Repository.instance;

  get repository => _repository;

  Stream<User> currentUser() {
    return _repository.currentUser();
  }

  Stream<Game> currentGame() {
    return _repository.currentGame();
  }
}
