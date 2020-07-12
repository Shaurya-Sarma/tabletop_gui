import 'package:flutter/material.dart';

import 'package:tabletop_gui/src/blocs/login_bloc.dart';
import 'package:tabletop_gui/src/blocs/login_bloc_provider.dart';
import 'package:tabletop_gui/src/screens/login.dart';
import 'package:tabletop_gui/src/screens/welcome.dart';
import 'package:tabletop_gui/src/utils/snackbar_utils.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Stack(children: <Widget>[
          Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 60.0, left: 30.0, bottom: 50.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "My Settings",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 34.0,
                    ),
                  ),
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    "ACCOUNT",
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                ),
                settingsButton("CHANGE PASSWORD", () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Password Reset"),
                          content: StreamBuilder(
                              stream: _bloc.email,
                              builder: (context, snapshot) {
                                return TextField(
                                  decoration: InputDecoration(
                                      hintText: "Enter Your Email",
                                      hintStyle:
                                          TextStyle(color: Colors.black38),
                                      errorText: snapshot.error),
                                  onChanged: _bloc.changeEmail,
                                  keyboardType: TextInputType.text,
                                );
                              }),
                          actions: <Widget>[
                            FlatButton(
                              child: Text('CANCEL',
                                  style: TextStyle(color: Colors.redAccent)),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            FlatButton(
                              child: Text('SEND',
                                  style: TextStyle(color: Colors.green)),
                              onPressed: () {
                                _bloc.sendPasswordResetEmail();
                                Navigator.of(context).pop();
                                SnackbarUtils.showSuccessMessage(
                                    "A password reset email has been sent to your email. Please follow the instructions to reset your password.",
                                    context);
                              },
                            )
                          ],
                        );
                      });
                }),
                Divider(
                  color: Colors.black38,
                  thickness: 2.0,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    "SUPPORT",
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                ),
                settingsButton(
                    "FEEDBACK",
                    () => openDialog("Feedback",
                        "It would appreciated if you want to share any thoughts, opinions, and comments regarding Tabletop. Please either write a review on the Google Play Store, or directly email me at shaurya.sarma@gmail.com. Thank you!")),
                settingsButton(
                    "PRIVACY POLICY",
                    () => _bloc.launchURL(
                        'https://shaurya-sarma.github.io/tabletop_gui/docs/privacy_policy.html')),
                settingsButton(
                    "ABOUT",
                    () => openDialog("About",
                        "Tabletop is created by Shaurya Sarma, and is intended to be an entertainment platform for all ages. If you have suggestions for any other games or bug fixes don't be hesistant to write some feedback. Thank you and I hope you enjoy Tabletop!")),
                Divider(
                  color: Colors.black38,
                  thickness: 2.0,
                ),
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                  child: Text(
                    "SETTINGS",
                    style: TextStyle(
                        color: Colors.blue[800],
                        fontWeight: FontWeight.w700,
                        fontSize: 18.0),
                  ),
                ),
                settingsButton("SIGN OUT", () {
                  _bloc.userLogout().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              LoginBlocProvider(child: LoginScreen()))));
                }),
                settingsButton("DELETE ACCOUNT", () {
                  _bloc.deleteAccount().then((value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => WelcomeScreen())));
                }),
              ]),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              height: 180,
              width: 180,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/orange_banner.png'),
                      fit: BoxFit.cover)),
            ),
          ),
        ]));
  }

  Widget settingsButton(String buttonText, Function callback) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: FlatButton(
        onPressed: () => callback(),
        padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              buttonText,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 20.0,
            )
          ],
        ),
      ),
    );
  }

  void openDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          actions: <Widget>[
            FlatButton(
              child: Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
