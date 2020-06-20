import 'package:tabletop_gui/src/models/entity.dart' show Entity;
import 'package:tabletop_gui/src/models/playing_card.dart';

class WarGame implements Entity {
  PlayingCard _playerOneCard;
  PlayingCard _playerTwoCard;
  List<PlayingCard> _playerOneDeck;
  List<PlayingCard> _playerTwoDeck;

  WarGame(
    this._playerOneCard,
    this._playerTwoCard,
    this._playerOneDeck,
    this._playerTwoDeck,
  );
  PlayingCard get playerOneCard => _playerOneCard;
  PlayingCard get playerTwoCard => _playerTwoCard;

  List<PlayingCard> get playerOneDeck => _playerOneDeck;
  List<PlayingCard> get playerTwoDeck => _playerTwoDeck;

  Map toJson() {
    Map map = {
      'playerOneCard': playerOneCard != null ? playerOneCard.toJson() : null,
      'playerTwoCard': playerTwoCard != null ? playerTwoCard.toJson() : null,
      'playerOneDeck':
          playerOneDeck != null ? playerOneDeck.map((e) => e.toJson()).toList() : null,
      'playerTwoDeck':
          playerTwoDeck != null ? playerTwoDeck.map((e) => e.toJson()).toList() : null,
    };

    return map;
  }

  static WarGame fromJson(Map map) {
    Map card1 = map["playerOneCard"];
    Map card2 = map["playerTwoCard"];
    List<Map> cardDeck1 = map["playerOneDeck"];
    List<Map> cardDeck2 = map["playerTwoDeck"];

    return WarGame(
      PlayingCard.fromJson(card1),
      PlayingCard.fromJson(card2),
      cardDeck1 != null ? cardDeck1.map((e) => PlayingCard.fromJson(e)) : null,
      cardDeck2 != null ? cardDeck2.map((e) => PlayingCard.fromJson(e)) : null,
    );
  }
}
