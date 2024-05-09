import 'package:flutter/cupertino.dart';
import 'package:industrial_watch/repositories/api_repo.dart';
import 'package:industrial_watch/utils/request_methods.dart';

class AttendanceViewmodel extends ChangeNotifier {
  List<dynamic> attendanceList = [];

  bool loading = true;

  Future<void> getAttendance(BuildContext context, int employee_id) async {
    loading = true;
    attendanceList.clear();
    await ApiRepo().apiFetch(
      context: context,
      path: 'Employee/GetEmployeeAttendance?employee_id=$employee_id',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        attendanceList = data;
        attendanceList = attendanceList.toSet().toList();
        print("Attendance >>>>> " + attendanceList.toString());
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        //customSnackBar(context, error.toString());
        loading = false;
        notifyListeners();
      },
    );
  }
}
