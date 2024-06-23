import 'package:industrial_watch/views/screens/admin/production/addProduct_screen.dart';
import 'package:industrial_watch/views/screens/admin/section/archives_screen.dart';
import 'package:industrial_watch/views/screens/supervisor/defect_monitoring/defect_monitoring.dart';
import '../views/screens/admin/employee_productivity/employee_record/employee_record.dart';
import '../views/screens/admin/employee_productivity/rankings_screen.dart';
import '../views/screens/admin/production/inventory/inventory_screen.dart';
import '../views/screens/admin/production/production_dashboard.dart';
import '../views/screens/admin/production/products/linkProduct_screen.dart';
import '../views/screens/admin/production/products/products_screen.dart';
import '../views/screens/admin/production/rawMaterial_screen.dart';
import '../views/screens/auth/login_screen.dart';
import 'package:industrial_watch/views/screens/admin/dashboard_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/empProdDashboard_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/add_employee_screen.dart';
import 'package:industrial_watch/views/screens/admin/employee_productivity/productivityRules_screen.dart';
import 'package:industrial_watch/views/screens/admin/section/addSection_screen.dart';
import 'package:industrial_watch/views/screens/admin/section/sections_screen.dart';
import 'package:industrial_watch/views/screens/admin/supervisor/supervisors_screen.dart';
import 'package:industrial_watch/views/screens/employee/dashboard_screen.dart';
import 'package:industrial_watch/views/screens/supervisor/dashboard_screen.dart';

import '../views/screens/employee/pages/attendance_screen.dart';
import '../views/screens/supervisor/defect_monitoring/onboarding_screen.dart';
import '../views/screens/supervisor/defect_monitoring/single_defect_monitoring.dart';
import '../views/screens/supervisor/employee_monitoring/employee_monitoring.dart';
import '../views/screens/supervisor/mark_attendance_screen.dart';

dynamic routes = {
  '/login': (context) => const LoginScreen(),
  '/admin': (context) => const AdminDashboard(),
  '/supervisor': (context) => const SupervisorDashboard(),
  '/employee': (context) => const EmployeeDashboard(),
  '/sections': (context) => const SectionsScreen(),
  '/addSection': (context) => const AddSectionScreen(),
  '/supervisorsView': (context) => const SupervisorScreen(),
  '/production': (context) => const ProductionScreen(),
  '/employeeProductivity': (context) => const EmployeeProductivityScreen(),
  '/rules': (context) => const ProductivityRulesScreen(),
  '/add_employee': (context) => const AddEmployeeScreen(),
  '/employee_ranking': (context) => const EmployeesRankingScreen(),
  '/employee_record': (context) => const EmployeeRecordScreen(),
  '/before_defect_monitoring': (context) => const OnBoardingScreen(),
  '/raw_materials': (context) => const RawMaterialScreen(),
  '/add_product': (context) => const AddProductScreen(),
  '/inventory': (context) => const InventoryScreen(),
  '/products': (context) => const ProductScreen(),
  '/linkProduct': (context) => const LinkProductScreen(),
  '/archives': (context) => const ArchivesScreen(),
  '/employee_monitoring': (context) => const EmployeeMonitoring(),
  '/defect_monitoring': (context) => const DefectMonitoring(),
  '/single_defect_monitoring': (context) => const SingleDefectMonitoring(),
  '/attendance': (context) => const EmployeeAttendanceScreen(),
  '/mark_attendance': (context) => const MarkAttendance(),
};
