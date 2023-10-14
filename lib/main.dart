import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/admin_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/rules_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/production/createBatch_viewModel.dart';
import 'package:industrial_watch/view-models/admin/production/production_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/section/addSection_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/section/sections_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/supervisor/addSupervisor_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/supervisor/supervisorsView_viewmodel.dart';
import 'package:industrial_watch/view-models/auth/login_viewmodel.dart';
import 'package:industrial_watch/view-models/employee/employee_viewmodel.dart';
import 'package:industrial_watch/view-models/supervisor/supervisor_viewmodel.dart';
import 'package:industrial_watch/views/screens/admin/dashboard_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/empProdDashboard_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/productivity_rules/productivityRules_screen.dart';
import 'package:industrial_watch/views/screens/admin/production/batch/createBatch_screen.dart';
import 'package:industrial_watch/views/screens/admin/production/production.dart';
import 'package:industrial_watch/views/screens/admin/section/addSection_screen.dart';
import 'package:industrial_watch/views/screens/admin/section/sections_screen.dart';
import 'package:industrial_watch/views/screens/admin/supervisor/addSupervisor_screen.dart';
import 'package:industrial_watch/views/screens/admin/supervisor/supervisors_screen.dart';
import 'package:industrial_watch/views/screens/auth/login_screen.dart';
import 'package:industrial_watch/views/screens/employee/dashboard_screen.dart';
import 'package:industrial_watch/views/screens/supervisor/dashboard_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus?.hasPrimaryFocus ?? false) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => LoginViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => AdminViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => EmployeeViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SupervisorViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SectionsViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => SupervisorsViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddSupervisorViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProductionViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => AddSectionViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => CreateBatchViewModel(),
          ),
          ChangeNotifierProvider(
            create: (context) => RulesViewModel(),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Industrial Watch',
          theme: ThemeData(
            useMaterial3: false,
            primaryColor: Colors.blue,
            //const Color(0xFF2E81FE),
          ),
          initialRoute: '/login',
          routes: {
            '/login': (context) => const LoginScreen(),
            '/admin': (context) => const AdminDashboard(),
            '/supervisor': (context) => const SupervisorDashboard(),
            '/employee': (context) => const EmployeeDashboard(),
            '/sections': (context) => const SectionsScreen(),
            '/addSection': (context) => const AddSectionScreen(),
            '/supervisorsView': (context) => const SupervisorScreen(),
            '/addSupervisor': (context) => const AddSupervisorScreen(),
            '/production': (context) => const ProductionScreen(),
            '/createBatch': (context) => const CreateBatchScreen(),
            '/employeeProductivity': (context) =>
                const EmployeeProductivityScreen(),
            '/rules': (context) => const ProductivityRulesScreen(),
          },
        ),
      ),
    );
  }
}
