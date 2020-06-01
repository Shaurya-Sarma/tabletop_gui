import 'firestore_provider.dart';
import 'package:tabletop_gui/src/models/user.dart';

class Repository {
  final _firestoreProvider = FirestoreProvider();

  Future<User> loginWithEmail(String email, String password) =>
      _firestoreProvider.loginWithEmail(email, password);

  Future<User> loginWithGoogle() => _firestoreProvider.loginWithGoogle();

  Future<void> registerWithEmail(
          String email, String password, String username) =>
      _firestoreProvider.registerWithEmail(email, password, username);

  Future<void> sendPasswordResetEmail(String email) =>
      _firestoreProvider.sendPasswordResetEmail(email);
}
