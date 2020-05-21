import 'package:flutter/widgets.dart';
import 'package:tabletop_gui/screens/welcome/welcome.dart';
import 'package:tabletop_gui/screens/login/login.dart';
import 'package:tabletop_gui/screens/register/register.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/register": (BuildContext context) => RegisterScreen(),
};
