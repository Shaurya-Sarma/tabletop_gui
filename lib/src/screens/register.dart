import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/widgets/logo.dart';
import 'package:tabletop_gui/src/screens/widgets/register_form.dart';

class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: Scaffold(
          body: SingleChildScrollView(
              child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 90.0, bottom: 50.0),
            child: TabletopLogo(),
          ),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.0),
              child: RegisterForm()),
          Padding(
              padding: EdgeInsets.only(top: 40.0),
              child: loginPageLink(context)),
        ],
      ))),
    );
  }

  Widget loginPageLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Already Have An Account? ",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
        children: <TextSpan>[
          TextSpan(
            text: 'Login Here',
            style: TextStyle(color: Color(0xff00B16A)),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, "/login");
              },
          ),
        ],
      ),
    );
  }
}
