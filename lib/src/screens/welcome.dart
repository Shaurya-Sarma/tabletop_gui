import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/screens/widgets/logo.dart';
import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/login.dart';

import 'package:tabletop_gui/src/utils/strings.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: backgroundImage(),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 225),
                  child: TabletopLogo(),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(bottom: 30),
                        child: signUpButton(context)),
                    Padding(
                        padding: EdgeInsets.only(bottom: 100),
                        child: loginButton(context))
                  ],
                )
              ],
            )));
  }

  //  colorFilter: ColorFilter.mode(
  //               Color(0xff00B16A).withOpacity(0.6), BlendMode.srcATop)

  Decoration backgroundImage() {
    return BoxDecoration(
        image: DecorationImage(
      image: AssetImage('assets/images/background.jpg'),
      fit: BoxFit.cover,
    ));
  }

  Widget signUpButton(BuildContext context) {
    return SizedBox(
        width: 275,
        height: 55,
        child: OutlineButton(
          child: Text(
            StringConstant.signUpButtonLabel,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 24.0),
          ),
          borderSide: BorderSide(color: Colors.white),
          shape: StadiumBorder(),
          onPressed: () => Navigator.pushNamed(context, '/register'),
        ));
  }

  Widget loginButton(BuildContext context) {
    return SizedBox(
        width: 275,
        height: 55,
        child: RaisedButton(
          child: Text(
            StringConstant.loginButtonLabel,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 24.0),
          ),
          shape: StadiumBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        LoginBlocProvider(child: LoginScreen())));
          },
        ));
  }
}
