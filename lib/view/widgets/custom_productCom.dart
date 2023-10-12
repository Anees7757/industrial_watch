import 'package:flutter/material.dart';

Widget customProductCom(String title, String value){
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text(title,
          style: const TextStyle(
            color: Color(0xFF616161),
            fontSize: 18,
          )),
      Container(
        margin: const EdgeInsets.only(left: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFDDDDDD).withOpacity(0.5),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(value,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
              )),
        ),
      ),
    ],
  );
}