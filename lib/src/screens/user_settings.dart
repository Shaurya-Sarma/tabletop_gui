import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/blocs/login_bloc.dart';
import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/login.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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

  Future<void> userLogout() async {
    _bloc.userLogout().then((value) => Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.red,
        child: Text(
          "Logout",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.w500, fontSize: 22.0),
        ),
        onPressed: () {
          userLogout();
        },
      ),
    );
  }
}
