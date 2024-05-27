import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

Map<String, dynamic> userData = {};

List<CameraDescription> cameras = [];

final Widget cancelButton = SvgPicture.asset(
  'assets/icons/cancel.svg',
  color: Colors.grey.shade400,
);
