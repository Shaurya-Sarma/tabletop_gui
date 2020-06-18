import 'package:tabletop_gui/src/models/playing_card.dart';

class WarGame {
  List<PlayingCard> _playerOneDeck;
  List<PlayingCard> _playerTwoDeck;
  PlayingCard _playerOneCard;
  PlayingCard _playerTwoCard;

  WarGame(
    this._playerOneCard,
    this._playerTwoCard,
    this._playerOneDeck,
    this._playerTwoDeck,
  );

  List<PlayingCard> get playerOneDeck => _playerOneDeck;
  List<PlayingCard> get playerTwoDeck => _playerTwoDeck;
  PlayingCard get playerOneCard => _playerOneCard;
  PlayingCard get playerTwoCard => _playerTwoCard;

  Map toJson() {
    return {
      'playerOneDeck': playerOneDeck,
      'playerTwoDeck': playerTwoDeck,
      'playerOneCard': playerOneCard,
      'playerTwoCard': playerTwoCard,
    };
  }
}
