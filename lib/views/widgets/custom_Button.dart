import 'package:flutter/material.dart';

Widget customButton(
    BuildContext context, String btnTitle, double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(height / 2.7),
      color: Theme.of(context).primaryColor,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 3,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Center(
      child: Text(
        btnTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
  );
}
