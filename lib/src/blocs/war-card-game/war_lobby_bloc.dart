import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tabletop_gui/src/blocs/base_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

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

  void launchURL() async {
    const url = 'https://gamerules.com/rules/war-card-game/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void dispose() async {
    await _userJoinCode.drain();
    _userJoinCode.close();
  }
}
