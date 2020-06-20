import 'package:tabletop_gui/src/models/entity.dart';

class Game {
  String _type;
  String _uid;
  List<dynamic> _players;
  Entity _game;

  Game(this._type, this._uid, this._players, this._game);

  String get type => _type;

  String get uuid => _uid;

  List<dynamic> get players => _players;

  Entity get game => _game;

  void setGame(Entity g) {
    _game = g;
  }
}
