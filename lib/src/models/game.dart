class Game {
  String _type;
  String _uid;
  List<dynamic> _players;
  Map<String, dynamic> _game;

  Game(this._type, this._uid, this._players, this._game);

  String get type => _type;

  String get uuid => _uid;

  List<dynamic> get players => _players;

  Map<String, dynamic> get game => _game;
}
