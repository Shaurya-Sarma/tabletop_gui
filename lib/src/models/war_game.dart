import 'package:tabletop_gui/src/models/entity.dart' show Entity;
import 'package:tabletop_gui/src/models/playing_card.dart';

class WarGame implements Entity {
  PlayingCard _playerOneCard;
  PlayingCard _playerTwoCard;
  List<PlayingCard> _playerOneDeck;
  List<PlayingCard> _playerTwoDeck;
  int _turnCounter = 0;
  int _winner = -1;
  List<PlayingCard> _tiedCards;
  bool _active = false;
  bool _playerOneTurn = true;

  WarGame(
      this._playerOneCard,
      this._playerTwoCard,
      this._playerOneDeck,
      this._playerTwoDeck,
      this._turnCounter,
      this._winner,
      this._tiedCards,
      this._active,
      this._playerOneTurn);
  PlayingCard get playerOneCard => _playerOneCard;
  PlayingCard get playerTwoCard => _playerTwoCard;

  List<PlayingCard> get playerOneDeck => _playerOneDeck;
  List<PlayingCard> get playerTwoDeck => _playerTwoDeck;

  int get turnCounter => _turnCounter;
  int get winner => _winner;

  List<PlayingCard> get tiedCards => _tiedCards;
  bool get active => _active;
  bool get playerOneTurn => _playerOneTurn;

  void setPlayerOneCard(PlayingCard card) {
    _playerOneCard = card;
  }

  void setPlayerTwoCard(PlayingCard card) {
    _playerTwoCard = card;
  }

  void setTurnCounter(int turnNumber) {
    _turnCounter = turnNumber;
  }

  void setWinner(int playerNumber) {
    _winner = playerNumber;
  }

  void setTiedCards(List<dynamic> cards) {
    _tiedCards = cards;
  }

  void setActive(bool active) {
    _active = active;
  }

  void setPlayerOneTurn(bool isPlayerOneTurn) {
    _playerOneTurn = isPlayerOneTurn;
  }

  Map toJson() {
    Map map = {
      'playerOneCard': playerOneCard != null ? playerOneCard.toJson() : null,
      'playerTwoCard': playerTwoCard != null ? playerTwoCard.toJson() : null,
      'playerOneDeck': playerOneDeck != null
          ? playerOneDeck.map((e) => e.toJson()).toList()
          : null,
      'playerTwoDeck': playerTwoDeck != null
          ? playerTwoDeck.map((e) => e.toJson()).toList()
          : null,
      'turnCounter': turnCounter,
      'winner': winner,
      'tiedCards':
          tiedCards != null ? tiedCards.map((e) => e.toJson()).toList() : null,
      'active': active,
      'playerOneTurn': playerOneTurn,
    };

    return map;
  }

  static WarGame fromJson(Map map) {
    Map card1 = map["playerOneCard"];
    Map card2 = map["playerTwoCard"];
    List<dynamic> cardDeck1 = map["playerOneDeck"];
    List<dynamic> cardDeck2 = map["playerTwoDeck"];
    List<dynamic> tiedCards = map["tiedCards"];

    return WarGame(
      PlayingCard.fromJson(card1),
      PlayingCard.fromJson(card2),
      cardDeck1 != null
          ? cardDeck1.map((e) => PlayingCard.fromJson(e)).toList()
          : null,
      cardDeck2 != null
          ? cardDeck2.map((e) => PlayingCard.fromJson(e)).toList()
          : null,
      map["turnCounter"],
      map["winner"],
      tiedCards != null
          ? tiedCards.map((e) => PlayingCard.fromJson(e)).toList()
          : null,
      map["active"],
      map["playerOneTurn"],
    );
  }
}
