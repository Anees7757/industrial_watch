import 'package:flutter/material.dart';

customNoDataWidget() {
  return SizedBox(
    width: double.infinity,
    height: double.infinity,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/no_data.jpg'),
        Text('No Data'),
      ],
    ),
  );
}
