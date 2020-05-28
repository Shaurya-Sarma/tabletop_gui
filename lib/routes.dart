import 'package:flutter/widgets.dart';
import 'package:tabletop_gui/screens/board/board.dart';

import 'package:tabletop_gui/screens/welcome/welcome.dart';
import 'package:tabletop_gui/screens/login/login.dart';
import 'package:tabletop_gui/screens/register/register.dart';
import 'package:tabletop_gui/screens/home/home.dart';
import 'package:tabletop_gui/screens/games/games.dart';
import 'package:tabletop_gui/screens/lobby/lobby.dart';
import 'package:tabletop_gui/screens/profile/profile.dart';
import 'package:tabletop_gui/screens/social/social.dart';
import 'package:tabletop_gui/screens/user_settings/user_settings.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => WelcomeScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/home": (BuildContext context) => HomeScreen(user: null),
  "/profile": (BuildContext context) => ProfileScreen(),
  "/games": (BuildContext context) => GamesScreen(),
  "/social": (BuildContext context) => SocialScreen(),
  "/settings": (BuildContext context) => SettingsScreen(),
  "/lobby": (BuildContext context) => LobbyScreen(),
  "/board": (BuildContext context) => BoardScreen(gameCode: null),
};
