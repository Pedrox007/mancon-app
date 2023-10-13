import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class NotificationMessage {
  Future<dynamic> showNotification(
      {bool error = false,
      required String message,
      required BuildContext context}) {
    return Flushbar(
      icon: error ? const Icon(Icons.warning) : const Icon(Icons.check),
      message: message,
      messageColor: Theme.of(context).colorScheme.secondary,
      messageSize: 14,
      backgroundColor: error
          ? Theme.of(context).colorScheme.error
          : Theme.of(context).colorScheme.primary,
      forwardAnimationCurve: Curves.easeIn,
      reverseAnimationCurve: Curves.easeOut,
      flushbarPosition: FlushbarPosition.BOTTOM,
      flushbarStyle: FlushbarStyle.FLOATING,
      margin: const EdgeInsets.all(10),
      duration: const Duration(milliseconds: 4000),
      borderRadius: BorderRadius.circular(10),
    ).show(context);
  }
}
