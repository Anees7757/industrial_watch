import 'package:flutter/material.dart';

customNoDataWidget() {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/no_data.jpg'),
        Text('No Data'),
      ],
    ),
  );
}
