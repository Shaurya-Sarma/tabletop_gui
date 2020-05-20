import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:tabletop_gui/main.dart';

import 'package:http/http.dart' as http;

class RegisterForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<int> attemptRegister(
      String username, String email, String password) async {
    var res = await http.post('$SERVER_IP/register',
        body: {"username": username, "email": email, "password": password});
    return res.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
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
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email, color: Colors.white),
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
                  onPressed: () async {
                    var username = usernameController.text;
                    var email = emailController.text;
                    var password = passwordController.text;

                    var res = await attemptRegister(username, email, password);
                    if (res == 201)
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text("Success"),
                            content: Text("You Have Successfully Registered!")),
                      );
                    else if (res == 409)
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content: Text(
                                "That Username Has Been Taken. Please Try Again")),
                      );
                    else {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                            title: Text("Error"),
                            content:
                                Text("Something Happened. Please Try Again")),
                      );
                    }
                  },
                )),
            Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: RichText(
                  text: TextSpan(
                    text: "Already Have An Account? ",
                    style: TextStyle(color: Colors.white, fontSize: 16.0),
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
