import 'dart:async';
import 'package:tabletop_gui/src/blocs/base_bloc.dart';
import 'package:tabletop_gui/src/utils/strings.dart';

import 'package:rxdart/rxdart.dart';

class LoginBloc extends BaseBloc {
  final _email = BehaviorSubject<String>();
  final _username = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  // final _isSignedIn = BehaviorSubject<bool>();

  Stream<String> get email => _email.stream.transform(_validateEmail);

  Stream<String> get username => _username.stream.transform(_validateUsername);

  Stream<String> get password => _password.stream.transform(_validatePassword);

  // BehaviorSubject<bool> get signInStatus => _isSignedIn.stream;

  String get emailAddress => _email.value;

  // Changes to Data
  Function(String) get changeEmail => _email.sink.add;

  Function(String) get changeUsername => _username.sink.add;

  Function(String) get changePassword => _password.sink.add;

  // Function(bool) get showProgressBar => _isSignedIn.sink.add;

  // All Validators
  final _validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError(StringConstant.emailValidateMessage);
    }
  });

  final _validatePassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 4) {
      sink.add(password);
    } else {
      sink.addError(StringConstant.passwordValidateMessage);
    }
  });

  final _validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    if (username.isNotEmpty) {
      sink.add(username);
    } else {
      sink.addError(StringConstant.usernameValidateMessage);
    }
  });

  bool validateFields() {
    if (_email.value != null &&
        _email.value.isNotEmpty &&
        _password.value != null &&
        _password.value.isNotEmpty &&
        RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
            .hasMatch(_email.value) &&
        _password.value.length >= 4) {
      return true;
    } else {
      return false;
    }
  }

  void loginWithEmail() {
    repository.loginWithEmail(_email.value, _password.value);
  }

  void loginWithGoogle() {
    repository.loginWithGoogle();
  }

  void registerWithEmail() {
    repository.registerWithEmail(
        _email.value, _password.value, _username.value);
  }

  void sendPasswordResetEmail() {
    repository.sendPasswordResetEmail(_email.value);
  }

  void dispose() async {
    await _email.drain();
    _email.close();
    await _password.drain();
    _password.close();
    await _username.drain();
    _username.close();
    // await _isSignedIn.drain();
    // _isSignedIn.close();
  }
}
