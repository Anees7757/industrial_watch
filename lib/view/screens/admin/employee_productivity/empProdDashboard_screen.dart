import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';

class EmployeeProductivityScreen extends StatefulWidget {
  const EmployeeProductivityScreen({super.key});

  @override
  State<EmployeeProductivityScreen> createState() =>
      _EmployeeProductivityScreenState();
}

class _EmployeeProductivityScreenState
    extends State<EmployeeProductivityScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text('Employee Productivity'),
        elevation: 0.0,
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(20, 100, 20, 0),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, -3),
                    ),
                  ]),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      // Provider.of<AdminViewModel>(context, listen: false)
                      //     .navigate(context, 'section');
                      Navigator.of(context).pushNamed('/rules');
                    },
                    child: customButton(
                        context, 'Productivity Rules', 78.29, double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      // Provider.of<AdminViewModel>(context, listen: false)
                      //     .navigate(context, 'supervisor');
                    },
                    child: customButton(
                        context, 'Add Employee', 78.29, double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      // Provider.of<AdminViewModel>(context, listen: false)
                      //     .navigate(context, 'productivity');
                    },
                    child: customButton(
                        context, 'Employee Record', 78.29, double.infinity),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
