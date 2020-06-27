import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/blocs/login_bloc.dart';
import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/utils/strings.dart';

import 'package:tabletop_gui/src/screens/home.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  LoginBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = LoginBlocProvider.of(context);
    _bloc.currentUser().listen((event) {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => HomeScreen(user: event)));
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: emailField(),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 20.0),
            child: passwordField(),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 20.0),
            child: GestureDetector(
                onTap: () {
                  _bloc.sendPasswordResetEmail();
                },
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.white70, fontSize: 18.0),
                )),
          ),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: loginButton(),
          ),
          Padding(
              padding: EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: connectWithDivider()),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              googleAuthButton(),
            ],
          ),
        ]);
  }

  Widget emailField() {
    return StreamBuilder(
        stream: _bloc.email,
        builder: (context, snapshot) {
          return TextField(
              style: TextStyle(color: Colors.white),
              onChanged: _bloc.changeEmail,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: StringConstant.emailFieldLabel,
                prefixIcon: Icon(Icons.email, color: Colors.white),
                errorText: snapshot.error,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ));
        });
  }

  Widget passwordField() {
    return StreamBuilder(
      stream: _bloc.password,
      builder: (context, snapshot) {
        return TextField(
            style: TextStyle(color: Colors.white),
            onChanged: _bloc.changePassword,
            keyboardType: TextInputType.visiblePassword,
            obscureText: true,
            decoration: InputDecoration(
              labelText: StringConstant.passwordFieldLabel,
              prefixIcon: Icon(Icons.lock, color: Colors.white),
              errorText: snapshot.error,
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white)),
            ));
      },
    );
  }

  Widget loginButton() {
    return RaisedButton(
      color: Color(0xff00B16A),
      child: Text(
        StringConstant.loginButtonLabel,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22.0),
      ),
      onPressed: () {
        if (_bloc.validateFields()) {
          _bloc.loginWithEmail().catchError((err) => showErrorMessage());
        } else {
          showErrorMessage();
        }
      },
    );
  }

  Widget connectWithDivider() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Divider(
          color: Colors.white,
          thickness: 2,
        )),
        Padding(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            child: Text(
              StringConstant.connectWith,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            )),
        Expanded(
            child: Divider(
          color: Colors.white,
          thickness: 2,
        )),
      ],
    );
  }

  Widget googleAuthButton() {
    return SignInButton(
      Buttons.GoogleDark,
      onPressed: () {
        _bloc.loginWithGoogle();
      },
    );
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text(StringConstant.loginErrorMessage),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
