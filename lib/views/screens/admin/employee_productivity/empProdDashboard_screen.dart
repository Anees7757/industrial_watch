import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/custom_gridview.dart';

class EmployeeProductivityScreen extends StatefulWidget {
  const EmployeeProductivityScreen({super.key});

  @override
  State<EmployeeProductivityScreen> createState() =>
      _EmployeeProductivityScreenState();
}

class _EmployeeProductivityScreenState
    extends State<EmployeeProductivityScreen> {
  final List<String> titles = [
    'Productivity Rules',
    'Add Employee',
    'Employees Record',
    'Employees Ranking'
  ];

  final List<String> icons = [
    'assets/icons/rules.png',
    'assets/icons/add_employee.png',
    'assets/icons/employee_record.png',
    'assets/icons/employee_rankings.png'
  ];

  final List<String> navigationVal = [
    'rules',
    'add_employee',
    'employee_record',
    'employee_ranking'
  ];

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      'assets/images/dashboard_box.svg',
      alignment: Alignment.topCenter,
      // colorFilter: ColorFilter.mode(
      //   Theme.of(context).primaryColor,
      //   BlendMode.lighten,
      // ),
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Employee Productivity'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          svg,
          Container(
            margin: const EdgeInsets.only(top: 130),
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                CustomGridView(
                  titles: titles,
                  navigationVal: navigationVal,
                  icons: icons,
                  dashboard: 'productivity',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
