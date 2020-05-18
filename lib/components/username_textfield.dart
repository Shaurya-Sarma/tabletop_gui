import 'package:flutter/material.dart';

class UsernameTextfield extends StatefulWidget {
  @override
  _UsernameTextfieldState createState() => _UsernameTextfieldState();
}

class _UsernameTextfieldState extends State<UsernameTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.0),
      child: TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Username",
            prefixIcon: Icon(Icons.person, color: Colors.white),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          )),
    );
  }
}
