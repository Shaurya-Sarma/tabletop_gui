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

    WarGame wg =
        WarGame(null, null, deck.sublist(0, 26), deck.sublist(26, deck.length));

    Game g = await currentGame().first;

    g.setGame(wg);
    repository.updateGame(g);
  }

  playerMove(int playerNumber) async {
    Game g = await currentGame().first;
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
