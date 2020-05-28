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
          'photoUrl':
              'data:image/jpeg;base64,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',
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
