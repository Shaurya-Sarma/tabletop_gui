import 'package:flutter/material.dart';

class SnackbarUtils {
  static void showErrorMessage(String errorMessage, BuildContext ctx) {
    final snackbar = SnackBar(
      content: Text(
        errorMessage,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: new Duration(seconds: 4),
      backgroundColor: Colors.red,
    );
    Scaffold.of(ctx).showSnackBar(snackbar);
  }

  static void showSuccessMessage(String errorMessage, BuildContext ctx) {
    final snackbar = SnackBar(
      content: Text(
        errorMessage,
        style: TextStyle(fontWeight: FontWeight.w500),
      ),
      duration: new Duration(seconds: 2),
      backgroundColor: Colors.green,
    );
    Scaffold.of(ctx).showSnackBar(snackbar);
  }
}
