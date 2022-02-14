import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

customSnackBar(BuildContext context, String text) {
  Flushbar(
    message: text,
    backgroundColor: Colors.grey.shade700,
    duration: const Duration(seconds: 2),
    flushbarPosition: FlushbarPosition.BOTTOM,
  ).show(context);
}
