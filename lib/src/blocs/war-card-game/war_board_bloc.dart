import 'package:tabletop_gui/src/blocs/base_bloc.dart';
import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/playing_card.dart';
import 'package:tabletop_gui/src/models/war_game.dart';

class WarBoardBloc extends BaseBloc {
  List<String> suits = ["clubs", "spades", "hearts", "diamonds"];
  Map<String, int> ranks = {
    "two": 2,
    "three": 3,
    "four": 4,
    "five": 5,
    "six": 6,
    "seven": 7,
    "eight": 8,
    "nine": 9,
    "ten": 10,
    "jack": 11,
    "queen": 12,
    "king": 13,
    "ace": 14,
  };

  void initGame() async {
    List<PlayingCard> deck = [];
    suits.forEach((suit) {
      ranks.forEach((rank, value) {
        deck.add(PlayingCard(suit, rank, value));
      });
    });

    deck.shuffle();

    WarGame wg = WarGame(null, null, deck.sublist(0, 26),
        deck.sublist(26, deck.length), 0, -1, [], false, true);

    wg.setActive(true);

    Game g = await currentGame().first;

    g.setGame(wg);
    repository.updateGame(g);
  }

  void playerMove(int playerNumber, Game game) {
    WarGame wg = game.game as WarGame;

    if (playerNumber == 0) {
      PlayingCard selectedCard = wg.playerOneDeck.removeAt(0);
      wg.setPlayerOneCard(selectedCard);
    } else {
      PlayingCard selectedCard = wg.playerTwoDeck.removeAt(0);
      wg.setPlayerTwoCard(selectedCard);
    }
    wg.setTurnCounter(wg.turnCounter + 1);
    wg.setPlayerOneTurn(!wg.playerOneTurn);

    game.setGame(wg);
    repository.updateGame(game);
  }

  void calculateWinner(Game g) {
    WarGame wg = g.game as WarGame;
    int winner = wg.playerOneCard.value == wg.playerTwoCard.value
        ? -1
        : wg.playerOneCard.value > wg.playerTwoCard.value ? 0 : 1;
    wg.setWinner(winner);
    switch (winner) {
      case -1:
        wg.tiedCards.addAll([wg.playerOneCard, wg.playerTwoCard]);
        break;
      case 0:
        wg.playerOneDeck.addAll([wg.playerOneCard, wg.playerTwoCard]);
        wg.playerOneDeck.addAll(wg.tiedCards);
        wg.playerOneDeck.shuffle();
        wg.tiedCards.clear();
        break;
      case 1:
        wg.playerTwoDeck.addAll([wg.playerOneCard, wg.playerTwoCard]);
        wg.playerTwoDeck.addAll(wg.tiedCards);
        wg.playerTwoDeck.shuffle();
        wg.tiedCards.clear();
        break;
    }

    wg.setTurnCounter(0);
    g.setGame(wg);
    repository.updateGame(g);
  }

  int checkGameOver(Game game, WarGame wg) {
    if (wg.playerOneDeck.length == 0) {
      return 1; // Player Two Wins
    } else if (wg.playerTwoDeck.length == 0) {
      return 0; // Player One Wins
    } else {
      return -1;
    }
  }

  void endGame(Game g) {
    WarGame wg = g.game as WarGame;
    wg.setActive(false);
    g.setGame(wg);
    repository.updateGame(g);
  }

  findGameData(String gameCode) {
    final gameData = repository.findGameData(gameCode);
    return gameData;
  }

  void exitGame(String gameCode) {
    repository.exitGame(gameCode);
  }

  void listenForChanges(String gameCode) {
    repository.listenForChanges(gameCode);
  }

  void dispose() {}
}
