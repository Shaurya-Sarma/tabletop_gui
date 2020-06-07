import 'package:flutter/widgets.dart';

import 'package:tabletop_gui/src/screens/games.dart';
import 'package:tabletop_gui/src/screens/home.dart';
import 'package:tabletop_gui/src/screens/login.dart';
import 'package:tabletop_gui/src/screens/profile.dart';
import 'package:tabletop_gui/src/screens/register.dart';
import 'package:tabletop_gui/src/screens/social.dart';
import 'package:tabletop_gui/src/screens/twenty-nine/twenty-nine_board.dart';
import 'package:tabletop_gui/src/screens/twenty-nine/twenty-nine_lobby.dart';
import 'package:tabletop_gui/src/screens/user_settings.dart';
import 'package:tabletop_gui/src/screens/welcome.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => WelcomeScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/home": (BuildContext context) => HomeScreen(user: null),
  "/profile": (BuildContext context) => ProfileScreen(user: null),
  "/games": (BuildContext context) => GamesScreen(),
  "/friends": (BuildContext context) => SocialScreen(),
  "/settiings": (BuildContext context) => SettingsScreen(),
  "/lobby": (BuildContext context) => LobbyScreen(),
  "/board": (BuildContext context) => BoardScreen(gameCode: null),
};
