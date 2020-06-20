import 'package:tabletop_gui/src/models/entity.dart';

class PlayingCard implements Entity {
  String _suit;
  String _rank;
  int _value;

  PlayingCard(this._suit, this._rank, this._value);

  String get suit => _suit;
  String get rank => _rank;
  int get value => _value;

  Map toJson() {
    return {"suit": suit, "rank": rank, "value": value};
  }

  static PlayingCard fromJson(Map map) {
    if (map != null && map.isNotEmpty)
      return PlayingCard(map["suit"], map["rank"], map["value"]);
    return null;
  }
}
