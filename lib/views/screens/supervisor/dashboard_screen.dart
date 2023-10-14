import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../view-models/supervisor/supervisor_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/logout_dialog.dart';

class SupervisorDashboard extends StatefulWidget {
  const SupervisorDashboard({super.key});

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

class _SupervisorDashboardState extends State<SupervisorDashboard> {
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
        elevation: 0.0,
        title: const Text('Supervisor Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              logoutDialogBox(
                  context,
                  () => Provider.of<SupervisorViewModel>(context, listen: false)
                      .logout(context));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Text('Welcome',
              style: TextStyle(fontSize: 15, color: Colors.grey.shade100)),
          const Text('Anwar Ali',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: Colors.white)),
          const SizedBox(height: 80),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 60),
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
                    onTap: () {},
                    child: customButton(
                        context, 'Employee Monitoring', 98.2, double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: customButton(
                        context, 'Defect Monitoring', 98.2, double.infinity),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {},
                    child: customButton(
                        context, 'Attendance', 98.2, double.infinity),
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
