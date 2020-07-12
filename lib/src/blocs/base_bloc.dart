import 'package:tabletop_gui/src/models/game.dart';
import 'package:tabletop_gui/src/models/user.dart';
import 'package:tabletop_gui/src/resources/repository.dart';
import 'package:url_launcher/url_launcher.dart';

class BaseBloc {
  final _repository = Repository.instance;

  get repository => _repository;

  Stream<User> currentUser() {
    return _repository.currentUser();
  }

  Stream<Game> currentGame() {
    return _repository.currentGame();
  }

  void launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
