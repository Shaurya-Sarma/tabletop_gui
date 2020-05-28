import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();

  String _username, _email, _password;

  bool _autoValidate = false;

  Future<void> userRegister() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();

      try {
        FirebaseUser user = (await FirebaseAuth.instance
                .createUserWithEmailAndPassword(
                    email: _email, password: _password))
            .user;

        user.sendEmailVerification();

        Firestore.instance.collection("users").document(user.uid).setData({
          'displayName': _username,
          'photoUrl': 'https://static.thenounproject.com/png/15599-200.png',
          'friends': [0],
          'email': _email,
        });

        Navigator.pushNamed(context, "/login");
      } catch (e) {
        print(e.message);
      }
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.text,
                  autovalidate: _autoValidate,
                  onSaved: (String input) => _username = input,
                  validator: (String input) {
                    if (input.isEmpty) {
                      return "Please enter an username";
                    } else if (input.length > 40) {
                      return "Username cannot be more than 40 characters";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Username",
                    prefixIcon: Icon(Icons.person, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: _autoValidate,
                  onSaved: (String input) => _email = input,
                  validator: (String input) {
                    bool emailValid = RegExp(
                            r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
                        .hasMatch(input);
                    if (input.isEmpty) {
                      return "Please enter an email";
                    } else if (!emailValid) {
                      return "Please enter a valid email";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  )),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 30.0),
              child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  keyboardType: TextInputType.visiblePassword,
                  autovalidate: _autoValidate,
                  onSaved: (String input) => _password = input,
                  validator: (String input) {
                    if (input.isEmpty) {
                      return "Please enter a password";
                    } else if (input.length < 4) {
                      return "Password must have more than 4 characters";
                    } else if (input.length > 40) {
                      return "Password must not have more than 40 characters";
                    } else {
                      return null;
                    }
                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.lock, color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white)),
                  )),
            ),
            SizedBox(
                width: double.infinity,
                height: 50,
                child: RaisedButton(
                  color: Color(0xffEB5757),
                  child: Text(
                    "REGISTER",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 22.0),
                  ),
                  onPressed: () {
                    userRegister();
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: RichText(
                  text: TextSpan(
                    text: "Already Have An Account? ",
                    style: TextStyle(color: Colors.white, fontSize: 18.0),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Login Here',
                        style: TextStyle(color: Color(0xff00B16A)),
                        recognizer: new TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.pushNamed(context, "/login");
                          },
                      ),
                    ],
                  ),
                )),
          ],
        ));
  }
}
