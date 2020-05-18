import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

class FacebookAuthButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SignInButton(
      Buttons.Facebook,
      onPressed: () {},
    );
  }
}
