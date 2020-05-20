import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tabletop_gui/main.dart';
import 'package:tabletop_gui/screens/home/home.dart';
import 'package:tabletop_gui/screens/login/components/google_button.dart';
import 'package:tabletop_gui/screens/login/components/facebook_button.dart';

import 'package:http/http.dart' as http;

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<String> attemptLogIn(String username, String password) async {
    var res = await http.post("$SERVER_IP/login",
        body: {"username": username, "password": password});
    if (res.statusCode == 200) return res.body;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 50.0),
            child: TextFormField(
                style: TextStyle(color: Colors.white),
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                )),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(bottom: 20.0),
            child: Text(
              "Forgot Password?",
              style: TextStyle(color: Colors.white70, fontSize: 16.0),
            ),
          ),
          SizedBox(
              width: double.infinity,
              height: 50,
              child: RaisedButton(
                color: Color(0xff00B16A),
                child: Text(
                  "LOGIN",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 22.0),
                ),
                onPressed: () async {
                  var username = usernameController.text;
                  var password = passwordController.text;

                  var jwt = await attemptLogIn(username, password);
                  if (jwt != null) {
                    storage.write(key: "jwt", value: jwt);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomeScreen.fromBase64(jwt)));
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                          title: Text("An Error Occured!"),
                          content: Text(
                              "No Account Was Found Matching That Username And Password")),
                    );
                  }
                },
              )),
          Padding(
            padding: EdgeInsets.only(top: 40.0, bottom: 10.0),
            child: Text(
              "Or Connect With",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[GoogleAuthButton(), FacebookAuthButton()],
          ),
          Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: RichText(
                text: TextSpan(
                  text: "Don't Have An Account? ",
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Register Here',
                      style: TextStyle(color: Colors.red),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, "/register");
                        },
                    ),
                  ],
                ),
              )),
        ]));
  }
}
