import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/widgets/login_form.dart';
import 'package:tabletop_gui/src/screens/widgets/logo.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginBlocProvider(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 30.0),
                alignment: Alignment.center, //? REMOVE
                child: TabletopLogo(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: LoginForm(),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: registerPageLink(context)),
            ],
          ),
        ),
      ),
    );
  }

  Widget registerPageLink(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "Don't Have An Account? ",
        style: TextStyle(color: Colors.white, fontSize: 18.0),
        children: <TextSpan>[
          TextSpan(
            text: 'Register Here',
            style: TextStyle(color: Colors.red),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                Navigator.pushNamed(context, "/register");
              },
          ),
        ],
      ),
    );
  }
}
