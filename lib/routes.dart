import 'package:flutter/widgets.dart';
import 'package:tabletop_gui/screens/user_settings/user_settings.dart';

import 'package:tabletop_gui/screens/welcome/welcome.dart';
import 'package:tabletop_gui/screens/login/login.dart';
import 'package:tabletop_gui/screens/register/register.dart';
import 'package:tabletop_gui/screens/home/home.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => WelcomeScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
  "/home": (BuildContext context) => HomeScreen(user: null),
  "/settings": (BuildContext context) => SettingsScreen(),
};
