import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/user.dart';
import 'package:tabletop_gui/src/models/war_game.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _currentUser = BehaviorSubject<User>();
  final _currentGame = BehaviorSubject<Game>();

  Stream<User> get currentUser => _currentUser.stream;
  Stream<Game> get currentGame => _currentGame.stream;

  // User Login With Email & Password
  Future<void> loginWithEmail(String email, String password) async {
    FirebaseUser user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;

    QuerySnapshot userInstance = await _firestore
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();
    Map currentUser = userInstance.documents.first.data;

    _currentUser.sink.add(User(currentUser["uid"], currentUser["displayName"],
        currentUser["email"], currentUser["photoUrl"], null));
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
  Future<void> registerWithEmail(
      String email, String password, String username) async {
    FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;

    user.sendEmailVerification();

    _firestore.collection("users").document(user.uid).setData({
      'displayName': username,
      'email': email,
      'photoUrl':
          'https://lh3.googleusercontent.com/4ChWnbUKurKdzUWVFlAPqGH9dzlUm9oAH8E4VxHwpW79MPeOY8HQOrkGG-KBVdaZVA=w300',
      'friends': null,
    });
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
      'game': {},
    });

    return lobbyCode;
  }

  Future<String> joinPrivateGame(String userJoinCode) async {
    QuerySnapshot gameInstance = await _firestore
        .collection("games")
        .where("uid", isEqualTo: "$userJoinCode")
        .getDocuments();

    if (gameInstance.documents.any((element) => element.exists)) {
      gameInstance.documents.forEach((doc) async {
        DocumentSnapshot document = await doc.reference.get();
        List<dynamic> players = document.data['players'];

        players.add(_currentUser.value.toJson());
        doc.reference.updateData({
          'players': players,
        });
      });
    } else {
      return 'false';
    }

    return userJoinCode;
  }

  void updateGame(Game gameObj) async {
    QuerySnapshot gameInstance = await Firestore.instance
        .collection("games")
        .where("uid", isEqualTo: "${gameObj.uuid}")
        .getDocuments();

    gameInstance.documents.forEach((doc) async {
      doc.reference.updateData({'game': gameObj.game.toJson()});
    });
  }

  void exitGame(String gameCode) async {
    QuerySnapshot gameInstance = await Firestore.instance
        .collection("games")
        .where("uid", isEqualTo: "$gameCode")
        .getDocuments();

    gameInstance.documents.forEach((doc) async {
      DocumentSnapshot document = await doc.reference.get();
      List<dynamic> players = document.data['players'];
      players.removeWhere(
          (element) => element["email"] == _currentUser.value.email);

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

    List<dynamic> players = gameData["players"];

    _currentGame.sink.add(
        Game(gameData["type"], gameData["uid"], players, gameData["game"]));

    return gameData;
  }

  void listenForChanges(String gameCode) {
    Query reference =
        _firestore.collection("games").where("uid", isEqualTo: "$gameCode");
    reference.snapshots().listen((querySnapshot) {
      Map<String, dynamic> gameData = querySnapshot.documents.first.data;
      List<dynamic> players = gameData["players"];
      Map game = gameData["game"];

      _currentGame.sink.add(Game(
          gameData["type"], gameData["uid"], players, WarGame.fromJson(game)));
    });
  }

  void dispose() async {
    await _currentUser.drain();
    _currentUser.close();

    await _currentGame.drain();
    _currentGame.close();
  }
}
