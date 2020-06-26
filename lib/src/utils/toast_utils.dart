import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tabletop_gui/src/utils/toast_animation.dart';

class ToastUtils {
  static Timer toastTimer;
  static OverlayEntry _overlayEntry;
  static Duration _duration = Duration(seconds: 2);

  static void showToast(
      BuildContext context, String message, Color toastColor) {
    if (toastTimer == null || !toastTimer.isActive) {
      _overlayEntry = createOverlayEntry(context, message, toastColor);
      Overlay.of(context).insert(_overlayEntry);
      toastTimer = Timer(_duration, () {
        if (_overlayEntry != null) {
          _overlayEntry.remove();
        }
      });
    }
  }

  static OverlayEntry createOverlayEntry(
      BuildContext context, String message, Color toastColor) {
    return OverlayEntry(
        builder: (context) => Positioned(
              top: 50,
              width: MediaQuery.of(context).size.width - 20,
              left: 10,
              child: ToastMessageAnimation(Material(
                elevation: 10,
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 13, 10, 10),
                  decoration: BoxDecoration(
                      color: toastColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      message,
                      textAlign: TextAlign.center,
                      softWrap: true,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              )),
            ));
  }
}
