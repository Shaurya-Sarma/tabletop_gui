class User {
  // Properties
  final String _displayName;
  final String _email;
  final List<User> _friends;
  final String _photoUrl;

  // Constructor
  User(this._displayName, this._email, this._photoUrl, this._friends);

  // Getters
  String get displayName => _displayName;
  String get email => _email;
  List<User> get friends => _friends;
  String get photoUrl => _photoUrl;
}
