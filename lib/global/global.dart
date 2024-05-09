import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:industrial_watch/models/violation_model.dart';

import '../models/employee_model.dart';

Map<String, dynamic> userData = {};

final Widget cancelButton = SvgPicture.asset(
  'assets/icons/cancel.svg',
  color: Colors.grey.shade400,
);

List<Employee> employees = [
  Employee(
    id: 005,
    name: 'Abdullah Mustafa',
    section: 'Management',
    productivity: 100,
    imageUrl: 'assets/images/person.png',
    email: '',
    gender: '',
    jobType: '',
    password: '',
    role: '',
  ),
  Employee(
    id: 976,
    name: 'Adeel Shahid',
    section: 'Marketing',
    productivity: 90,
    imageUrl: 'assets/images/person.png',
    email: '',
    gender: '',
    jobType: '',
    password: '',
    role: '',
  ),
  Employee(
    id: 589,
    name: 'Usama Fayyaz',
    section: 'Manufacturing',
    productivity: 85,
    imageUrl: 'assets/images/person.png',
    email: 'usama@gmail.com',
    gender: 'Male',
    jobType: 'Full Time',
    password: 'usama123',
    role: 'Mechanic',
  ),
  Employee(
    id: 738,
    name: 'Muhammad Anees',
    section: 'Packing',
    productivity: 60,
    imageUrl: 'assets/images/person.png',
    email: '',
    gender: '',
    jobType: '',
    password: '',
    role: '',
  ),
];

List<Violation> violations = [
  Violation(
    id: 1,
    title: 'Mobile Usage',
    date: '20 May 2023',
    time: '11:00 PM',
    images: [
      'assets/images/violation.png',
      'assets/images/violation.png',
      'assets/images/violation.png',
    ],
    empId: 589,
  ),
  Violation(
    id: 2,
    title: 'Smoking',
    date: '25 May 2023',
    time: '11:30 PM',
    images: [
      'assets/images/violation.png',
      'assets/images/violation.png',
      'assets/images/violation.png',
      'assets/images/violation.png',
    ],
    empId: 589,
  ),
  Violation(
    id: 3,
    title: 'Mobile Usage',
    date: '10 August 2023',
    time: '09:00 AM',
    images: [
      'assets/images/violation.png',
      'assets/images/violation.png',
    ],
    empId: 005,
  ),
];
