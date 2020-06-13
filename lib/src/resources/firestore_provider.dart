import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/user.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _currentUser = BehaviorSubject<User>();
  final _currentGame = BehaviorSubject<Game>();

  Stream<User> get currentUser => _currentUser.stream;
  Stream<Game> get currentGame => _currentGame.stream;

  // User Login With Email & Password
  void loginWithEmail(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      _currentUser.sink.add(
          User(user.uid, user.displayName, user.email, user.photoUrl, null));
    } catch (e) {
      print(e.message);
      throw e;
    }
  }

  // User Sign In With Google Account
  void loginWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final AuthResult authResult = await _auth.signInWithCredential(credential);
    final FirebaseUser user = authResult.user;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final FirebaseUser currentUser = await _auth.currentUser();
    assert(user.uid == currentUser.uid);

    _firestore.collection("users").document(currentUser.uid).setData({
      'displayName': currentUser.displayName,
      'email': currentUser.email,
      'photoUrl': currentUser.photoUrl,
      'friends': null,
    });

    _currentUser.sink
        .add(User(user.uid, user.displayName, user.email, user.photoUrl, null));
  }

  // Register User With Email & Password
  void registerWithEmail(String email, String password, String username) async {
    try {
      FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;

      user.sendEmailVerification();

      _firestore.collection("users").document(user.uid).setData({
        'displayName': username,
        'email': email,
        'photoUrl':
            'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/user-alt-512.png',
        'friends': null,
      });
    } catch (e) {
      print(e.message);
      throw e;
    }
  }

  // Send User Password Reset Mail
  void sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

  String createPrivateGame(
    String lobbyCode,
    String gameType,
  ) {
    _firestore.collection("games").add({
      'uid': '$lobbyCode',
      'type': '$gameType',
      'players': [_currentUser.value.toJson()],
      'game': {}
    });

    return lobbyCode;
  }

  Future<String> joinPrivateGame(String userJoinCode) async {
    QuerySnapshot gameInstance = await _firestore
        .collection("games")
        .where("uid", isEqualTo: "$userJoinCode")
        .getDocuments();

    gameInstance.documents.forEach((doc) async {
      DocumentSnapshot document = await doc.reference.get();
      List<dynamic> players = document.data['players'];

      players.add(_currentUser.value.toJson());
      doc.reference.updateData({
        'players': players,
      });
    });

    return userJoinCode;
  }

  void exitGame(String gameCode) async {
    QuerySnapshot gameInstance = await Firestore.instance
        .collection("games")
        .where("uid", isEqualTo: "$gameCode")
        .getDocuments();

    gameInstance.documents.forEach((doc) async {
      DocumentSnapshot document = await doc.reference.get();
      List<dynamic> players = document.data['players'];
      players.remove(_currentUser.value);
      doc.reference.updateData({
        'players': players,
      });
    });
  }

  findGameData(String gameCode) async {
    QuerySnapshot gameInstance = await Firestore.instance
        .collection("games")
        .where("uid", isEqualTo: "$gameCode")
        .getDocuments();

    Map<String, dynamic> gameData = gameInstance.documents.first.data;

    //print('players ${gameData["players"]}');
    List<dynamic> players = gameData["players"];
    //players.cast<User>().toList();

    _currentGame.sink.add(
        Game(gameData["type"], gameData["uid"], players, gameData["game"]));

    return gameData;
  }

  void dispose() async {
    await _currentUser.drain();
    _currentUser.close();

    await _currentGame.drain();
    _currentGame.close();
  }
}