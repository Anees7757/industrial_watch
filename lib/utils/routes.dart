import 'package:industrial_watch/views/screens/employee/pages/home_screen.dart';

import '../views/screens/admin/employee_productivity/employee_record/record_details/employee_details/attendance.dart';
import '../views/screens/admin/employee_productivity/employee_record/employee_record.dart';
import '../views/screens/admin/employee_productivity/rankings_screen.dart';
import '../views/screens/auth/login_screen.dart';
import 'package:industrial_watch/views/screens/admin/dashboard_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/empProdDashboard_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/add_employee_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/productivityRules_screen.dart';
import 'package:industrial_watch/views/screens/admin/production/batch/createBatch_screen.dart';
import 'package:industrial_watch/views/screens/admin/production/production.dart';
import 'package:industrial_watch/views/screens/admin/section/addSection_screen.dart';
import 'package:industrial_watch/views/screens/admin/section/sections_screen.dart';
import 'package:industrial_watch/views/screens/admin/supervisor/addSupervisor_screen.dart';
import 'package:industrial_watch/views/screens/admin/supervisor/supervisors_screen.dart';
import 'package:industrial_watch/views/screens/employee/dashboard_screen.dart';
import 'package:industrial_watch/views/screens/supervisor/dashboard_screen.dart';

import '../views/screens/supervisor/defect_monitoring/onboarding_screen.dart';

dynamic routes = {
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
  '/employeeProductivity': (context) => const EmployeeProductivityScreen(),
  '/rules': (context) => const ProductivityRulesScreen(),
  '/add_employee': (context) => const AddEmployeeScreen(),
  '/employee_ranking': (context) => const EmployeesRankingScreen(),
  '/employee_record': (context) => const EmployeeRecordScreen(),
  '/before_defect_monitoring': (context) => const OnBoardingScreen(),
};
