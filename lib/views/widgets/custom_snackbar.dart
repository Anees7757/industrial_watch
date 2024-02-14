import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Align(
      alignment: Alignment.centerLeft,
      child: Text(
        msg,
        style: const TextStyle(color: Colors.white),
      ),
    ),
    elevation: 0.0,
    duration: const Duration(seconds: 2),
    behavior: SnackBarBehavior.floating,
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
