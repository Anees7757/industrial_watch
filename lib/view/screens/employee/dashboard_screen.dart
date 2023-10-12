import 'package:flutter/material.dart';
import 'package:industrial_watch/view/widgets/logout_dialog.dart';
import 'package:provider/provider.dart';

import '../../view-model/employee/employee_viewmodel.dart';

class EmployeeDashboard extends StatefulWidget {
  const EmployeeDashboard({super.key});

  @override
  State<EmployeeDashboard> createState() => _EmployeeDashboardState();
}

class _EmployeeDashboardState extends State<EmployeeDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Dashboard'),
        actions: [
          IconButton(
            onPressed: () {
              logoutDialogBox(
                  context,
                  () => Provider.of<EmployeeViewModel>(context, listen: false)
                      .logout(context));
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Placeholder(),
    );
  }
}
