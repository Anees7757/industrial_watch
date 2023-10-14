import 'package:flutter/material.dart';

void customSnackBar(BuildContext context, String msg) {
  final snackBar = SnackBar(
    content: Container(
      height: 50,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    duration: const Duration(seconds: 2),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
