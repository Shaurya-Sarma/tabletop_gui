import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tabletop_gui/src/models/user.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final _currentUser = BehaviorSubject<User>();

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

  Stream<User> get currentUser => _currentUser.stream;

  void createPrivateGame(
    String lobbyCode,
    String gameType,
  ) {
    _firestore.collection("games").add({
      'uuid': '$lobbyCode',
      'type': '$gameType',
      'players': ['${_currentUser.value}'],
      'game': {
        'score': 0,
        'teamOne': ["", ""],
        'teamTwo': ["", ""],
      }
    });
  }

  void joinPrivateGame(String userJoinCode) async {
    QuerySnapshot gameInstance = await _firestore
        .collection("games")
        .where("uuid", isEqualTo: "$userJoinCode")
        .getDocuments();

    gameInstance.documents.forEach((doc) async {
      DocumentSnapshot document = await doc.reference.get();
      List<dynamic> players = document.data['players'];

      final FirebaseUser currentUser = await _auth.currentUser();

      players.add('${currentUser.uid}');
      doc.reference.updateData({
        'players': players,
      });
    });
  }

  void dispose() async {
    await _currentUser.drain();
    _currentUser.close();
  }
}
