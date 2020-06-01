import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tabletop_gui/src/models/user.dart';

class FirestoreProvider {
  final Firestore _firestore = Firestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // User Login With Email & Password
  Future<User> loginWithEmail(String email, String password) async {
    try {
      FirebaseUser user = (await _auth.signInWithEmailAndPassword(
              email: email, password: password))
          .user;
      return User(user.displayName, user.email, user.photoUrl, null);
    } catch (e) {
      print(e.message);
      throw e;
    }
  }

  // User Sign In With Google Account
  Future<User> loginWithGoogle() async {
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

    return User(user.displayName, user.email, user.photoUrl, null);
  }

  // Register User With Email & Password
  Future<void> registerWithEmail(
      String email, String password, String username) async {
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
  Future<void> sendPasswordResetEmail(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }
}
