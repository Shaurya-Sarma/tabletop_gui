import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/blocs/login_bloc.dart';
import 'package:tabletop_gui/src/utils/strings.dart';
import 'package:tabletop_gui/src/utils/fade_animation.dart';

import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:tabletop_gui/src/screens/home.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
    _bloc.currentUser().listen((event) {
      if (event.email != null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomeScreen(user: event)));
      }
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Builder(
          builder: (ctx) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage('assets/images/login_background.png'),
                          fit: BoxFit.cover)),
                  child: Stack(
                    children: [
                      Positioned(
                        left: 30,
                        top: 50,
                        child: GestureDetector(
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onTap: () => Navigator.pop(ctx),
                        ),
                      )
                    ],
                  )),
              FadeIn(
                  1.0,
                  Container(
                      margin: EdgeInsets.symmetric(horizontal: 30.0),
                      child: RichText(
                          text: TextSpan(
                              text: 'Hello, \nWelcome Back',
                              style: TextStyle(
                                  fontSize: 40.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                              children: [
                            TextSpan(
                                text: '.',
                                style: TextStyle(
                                    fontSize: 46.0,
                                    color: Color(0xff4A00E0),
                                    fontWeight: FontWeight.w900))
                          ])))),
              FadeIn(
                  1.5,
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 40.0),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(8),
                          child: emailField(),
                        ),
                        Container(
                          padding: EdgeInsets.all(8),
                          child: passwordField(),
                        )
                      ],
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                              color: Color(0x564A00E0),
                              blurRadius: 20.0,
                              offset: Offset(0, 10))
                        ]),
                  )),
              FadeIn(
                  1.5,
                  Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 30.0,
                    ),
                    alignment: Alignment.centerRight,
                    child: forgotPassword(ctx),
                  )),
              FadeIn(2.0, loginBtn(ctx)),
              FadeIn(2.0, googleSignInBtn(ctx)),
            ],
          ),
        ));
  }

  Widget emailField() {
    return StreamBuilder(
        stream: _bloc.email,
        builder: (context, snapshot) {
          return TextField(
              style: TextStyle(color: Colors.grey[700]),
              onChanged: _bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15.0),
                hintText: StringConstant.emailFieldLabel,
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: Icon(Icons.email, color: Colors.grey[700]),
                border: InputBorder.none,
              ));
        });
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: _bloc.password,
      builder: (context, snapshot) {
        return TextField(
            style: TextStyle(color: Colors.grey[700]),
            onChanged: _bloc.changePassword,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 15.0),
                hintText: StringConstant.passwordFieldLabel,
                hintStyle: TextStyle(color: Colors.grey[700]),
                prefixIcon: Icon(Icons.lock, color: Colors.grey[700]),
                border: InputBorder.none));
      },
    );
  }

  Widget forgotPassword(BuildContext ctx) {
    return GestureDetector(
        onTap: () {
          _bloc.sendPasswordResetEmail().catchError((err) {
            showErrorMessage(
                "User Not Found. Please Enter A Valid Email.", ctx);
          });
        },
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.grey[700], fontSize: 16.0),
        ));
  }

  Widget loginBtn(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: RaisedButton(
        onPressed: () {
          if (_bloc.validateFields()) {
            _bloc.loginWithEmail().catchError((err) {
              showErrorMessage("$err Please Try Again.", ctx);
            });
          } else {
            showErrorMessage("Invalid Fields! Please Try Again.", ctx);
          }
        },
        padding: EdgeInsets.all(0.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                  colors: [Color(0x998E2DE2), Color(0x994A00E0)])),
          child: Center(
            child: Text(
              "LOGIN",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget googleSignInBtn(BuildContext ctx) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      child: SignInButton(
        Buttons.Google,
        onPressed: () {
          _bloc.loginWithGoogle().catchError((err) =>
              showErrorMessage("Error Occured! Please Try Again!", ctx));
        },
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      ),
    );
  }

  void showErrorMessage(String errorMessage, BuildContext ctx) {
    final snackbar = SnackBar(
      content: Text(
        errorMessage,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: new Duration(seconds: 4),
      backgroundColor: Colors.red,
    );
    Scaffold.of(ctx).showSnackBar(snackbar);
  }
}
