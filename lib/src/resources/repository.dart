import 'package:tabletop_gui/src/models/game.dart';

import 'firestore_provider.dart';
import 'package:tabletop_gui/src/models/user.dart';

class Repository {
  Repository._privateConstructor();

  static final Repository instance = Repository._privateConstructor();

  final _firestoreProvider = FirestoreProvider();

  Future<void> loginWithEmail(String email, String password) =>
      _firestoreProvider.loginWithEmail(email, password);

  void loginWithGoogle() => _firestoreProvider.loginWithGoogle();

  Future<void> userLogout() => _firestoreProvider.userLogout();

  Future<void> deleteAccount(String uid) =>
      _firestoreProvider.deleteAccount(uid);

  Future<void> registerWithEmail(
          String email, String password, String username) =>
      _firestoreProvider.registerWithEmail(email, password, username);

  Future<void> sendPasswordResetEmail(String email) =>
      _firestoreProvider.sendPasswordResetEmail(email);

  Stream<User> currentUser() {
    return _firestoreProvider.currentUser;
  }

  Stream<Game> currentGame() {
    return _firestoreProvider.currentGame;
  }

  String createPrivateGame(String lobbyCode, String gameType) {
    return _firestoreProvider.createPrivateGame(lobbyCode, gameType);
  }

  Future<String> joinPrivateGame(String userJoinCode) {
    return _firestoreProvider.joinPrivateGame(userJoinCode);
  }

  void updateGame(Game gameObj) {
    _firestoreProvider.updateGame(gameObj);
  }

  void exitGame(String gameCode) {
    _firestoreProvider.exitGame(gameCode);
  }

  dynamic findGameData(String gameCode) {
    return _firestoreProvider.findGameData(gameCode);
  }

  void listenForChanges(String collectionName) {
    return _firestoreProvider.listenForChanges(collectionName);
  }
}
