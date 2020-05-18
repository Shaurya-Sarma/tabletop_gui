import 'package:flutter/widgets.dart';
import 'package:tabletop_gui/screens/welcome/welcome.dart';
import 'package:tabletop_gui/screens/login/login.dart';

final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/": (BuildContext context) => WelcomeScreen(),
  "/login": (BuildContext context) => LoginScreen(),
};
