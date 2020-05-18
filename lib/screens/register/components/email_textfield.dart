import 'package:flutter/material.dart';

class EmailTextfield extends StatefulWidget {
  @override
  _EmailTextfieldState createState() => _EmailTextfieldState();
}

class _EmailTextfieldState extends State<EmailTextfield> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 50.0),
      child: TextFormField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: "Email",
            prefixIcon: Icon(Icons.email, color: Colors.white),
            enabledBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          )),
    );
  }
}
