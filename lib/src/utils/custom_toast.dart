import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Future<bool?> showCustomToast(String message, {
  gravity = ToastGravity.CENTER, toastLength = Toast.LENGTH_LONG, backgroundColor = Colors.red
}) {
  return Fluttertoast.showToast(
        msg: message,
        gravity: gravity,
        toastLength: toastLength,
        backgroundColor: backgroundColor
  );
}