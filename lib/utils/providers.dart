import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/attendance_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/summary_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/violationsDetail_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/violations_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/ranking_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/production/batch_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/production/inventory_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/production/rawMaterials_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/section/archive_viewmodel.dart';
import 'package:industrial_watch/view-models/employee/profile_viewmodel.dart';
import 'package:industrial_watch/view-models/supervisor/defect_monitoring_viewmodel.dart';
import 'package:industrial_watch/view-models/supervisor/employee_monitoring_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:industrial_watch/view-models/admin/admin_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/rules_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/production/addProduct_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/production/production_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/section/addSection_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/section/sections_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/supervisor/editSupervisor_viewmodel.dart';
import 'package:industrial_watch/view-models/admin/supervisor/supervisorsView_viewmodel.dart';
import 'package:industrial_watch/view-models/auth/login_viewmodel.dart';
import 'package:industrial_watch/view-models/employee/employee_viewmodel.dart';
import 'package:industrial_watch/view-models/supervisor/supervisor_viewmodel.dart';
import '../view-models/admin/employee_productivity/addEmployee_viewmodel.dart';
import '../view-models/admin/employee_productivity/employeeRecord_viewmodel.dart';
import '../view-models/admin/employee_productivity/employee_record/empolyeeDetail_viewmodel.dart';
import '../view-models/admin/production/batchDetails_viewmodel.dart';
import '../view-models/admin/production/chooseStock_viewmodel.dart';
import '../view-models/admin/production/createBatch_viewmodel.dart';
import '../view-models/admin/production/inventoryDetail_viewmodel.dart';
import '../view-models/admin/production/linkProduct_viewmodel.dart';
import '../view-models/admin/production/products_viewmodel.dart';
import '../view-models/admin/section/editSection_viewmodel.dart';
import '../view-models/admin/section/sectionDetails_viewmodel.dart';
import '../view-models/employee/editProfile_viewmodel.dart';
import '../view-models/supervisor/mark_attendance_viewmodel.dart';
import '../view-models/supervisor/single_defect_monitoring_viewmodel.dart';

dynamic providers = [
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
    create: (context) => EditSectionViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SupervisorsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => EditSupervisorViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProductionViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddSectionViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SectionDetailViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => RulesViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddProductViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => EmployeesRankingViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AddEmployeeViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SummaryViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => EditProfileViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => RawMaterialsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => InventoryViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => InventoryDetailViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => BatchViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProductViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => LinkProductViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => CreateBatchViewmodel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ChooseStockViewmodel(),
  ),
  ChangeNotifierProvider(
    create: (context) => BatchDetailsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ArchivesViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => EmployeeRecordViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => EmployeeDetailViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => AttendanceViewmodel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ViolationsViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ViolationsDetailViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => ProfileViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => EmployeeMonitoringViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => DefectMonitoringViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => SingleDefectMonitoringViewModel(),
  ),
  ChangeNotifierProvider(
    create: (context) => MarkAttendanceViewModel(),
  ),
];
