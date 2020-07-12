import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tabletop_gui/src/blocs/base_bloc.dart';

class WarLobbyBloc extends BaseBloc {
  final _userJoinCode = BehaviorSubject<String>();

  Stream<String> get userJoinCode => _userJoinCode.stream;

  Function(String) get changeUserJoinCode => _userJoinCode.sink.add;

  Future<String> createPrivateGame() async {
    return repository.createPrivateGame(UniqueKey().toString(), "War");
  }

  Future<String> joinPrivateGame() async {
    return repository.joinPrivateGame(_userJoinCode.value);
  }

  void dispose() async {
    await _userJoinCode.drain();
    _userJoinCode.close();
  }
}
