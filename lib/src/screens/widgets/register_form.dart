import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/blocs/login_bloc.dart';
import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/utils/strings.dart';
import 'package:tabletop_gui/src/utils/toast_utils.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
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
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: usernameField(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: emailField(),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 30.0),
          child: passwordField(),
        ),
        SizedBox(
          width: double.infinity,
          height: 50,
          child: registerButton(),
        ),
      ],
    );
  }

  Widget usernameField() {
    return StreamBuilder(
        stream: _bloc.username,
        builder: (context, snapshot) {
          return TextField(
              style: TextStyle(color: Colors.white),
              onChanged: _bloc.changeUsername,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: StringConstant.usernameField,
                prefixIcon: Icon(Icons.person, color: Colors.white),
                errorText: snapshot.error,
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white)),
              ));
        });
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

  Widget registerButton() {
    return RaisedButton(
      color: Color(0xffEB5757),
      child: Text(
        StringConstant.registerButtonLabel,
        style: TextStyle(
            color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22.0),
      ),
      onPressed: () {
        if (_bloc.validateFields()) {
          _bloc.registerWithEmail().then((value) {
            Navigator.pushNamed(context, '/login');
            ToastUtils.showToast(
                context, "User Successfully Created!", Colors.green);
          }).catchError((e) {
            showErrorMessage();
          });
        } else {
          showErrorMessage();
        }
      },
    );
  }

  void showErrorMessage() {
    final snackbar = SnackBar(
        content: Text(StringConstant.registerErrorMessage),
        duration: new Duration(seconds: 2));
    Scaffold.of(context).showSnackBar(snackbar);
  }
}
