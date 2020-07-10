import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:tabletop_gui/src/blocs/login_bloc.dart';

import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/login.dart';
import 'package:tabletop_gui/src/utils/fade_animation.dart';
import 'package:tabletop_gui/src/utils/snackbar_utils.dart';
import 'package:tabletop_gui/src/utils/strings.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
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
                              image: AssetImage(
                                  'assets/images/register_background.png'),
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
                          margin: EdgeInsets.symmetric(
                            horizontal: 30.0,
                          ),
                          alignment: Alignment.centerRight,
                          child: RichText(
                              textAlign: TextAlign.right,
                              text: TextSpan(
                                  text: 'First Time? \nSign Up Here',
                                  style: TextStyle(
                                      fontSize: 40.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black),
                                  children: [
                                    TextSpan(
                                        text: '.',
                                        style: TextStyle(
                                            fontSize: 46.0,
                                            color: Color(0xffF12711),
                                            fontWeight: FontWeight.w900))
                                  ]))),
                      30.0),
                  FadeIn(
                      1.5,
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 30.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(4),
                              child: usernameField(),
                            ),
                            Container(
                              padding: EdgeInsets.all(4),
                              child: emailField(),
                            ),
                            Container(
                              padding: EdgeInsets.fromLTRB(4, 4, 4, 12),
                              child: passwordField(),
                            )
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0x56F12711),
                                  blurRadius: 20.0,
                                  offset: Offset(0, 6))
                            ]),
                      ),
                      30.0),
                  FadeIn(2.0, registerBtn(ctx), 30.0)
                ],
              )),
    );
  }

  Widget usernameField() {
    return StreamBuilder(
        stream: _bloc.username,
        builder: (context, snapshot) {
          return TextField(
              style: TextStyle(color: Colors.grey[700]),
              onChanged: _bloc.changeUsername,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 15.0, left: 10.0),
                  hintText: StringConstant.usernameFieldLabel,
                  hintStyle: TextStyle(color: Colors.grey[700]),
                  errorText: snapshot.error,
                  errorStyle: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  prefixIcon: Icon(Icons.person, color: Colors.grey[700]),
                  border: InputBorder.none));
        });
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
                contentPadding: EdgeInsets.only(top: 15.0, left: 10.0),
                hintText: StringConstant.emailFieldLabel,
                hintStyle: TextStyle(color: Colors.grey[700]),
                errorText: snapshot.error,
                errorStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
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
                contentPadding: EdgeInsets.only(top: 15.0, left: 10.0),
                hintText: StringConstant.passwordFieldLabel,
                hintStyle: TextStyle(color: Colors.grey[700]),
                errorText: snapshot.error,
                errorStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.grey[700]),
                border: InputBorder.none));
      },
    );
  }

  Widget registerBtn(BuildContext ctx) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.0, vertical: 30.0),
      child: RaisedButton(
        onPressed: () {
          if (_bloc.validateFields()) {
            _bloc.registerWithEmail().then((value) {
              SnackbarUtils.showSuccessMessage(
                  "User Successfully Created!", ctx);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginBlocProvider(child: LoginScreen())));
            }).catchError((err) {
              SnackbarUtils.showErrorMessage("$err Please Try Again.", ctx);
            });
          } else {
            SnackbarUtils.showErrorMessage(
                "Invalid Fields! Please Try Again.", ctx);
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
                  colors: [Color(0xffF12711), Color(0xffF5AF19)])),
          child: Center(
            child: Text(
              "SIGN UP",
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
}
