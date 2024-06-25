import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/view-models/supervisor/employee_monitoring_viewmodel.dart';
import 'package:industrial_watch/views/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';

class EmployeeMonitoring extends StatefulWidget {
  const EmployeeMonitoring({Key? key}) : super(key: key);

  @override
  State<EmployeeMonitoring> createState() => _EmployeeMonitoringState();
}

class _EmployeeMonitoringState extends State<EmployeeMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EmployeeMonitoringViewModel>(
        builder: (context, viewmodel, child) {
      return Scaffold(
        appBar: customAppBar(context, 'Employee Monitoring'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await viewmodel.getVideo(ImageSource.gallery);
                  viewmodel.uploadVideo(context);
                },
                child:
                    customButton(context, 'Choose Video from Gallery', 50, 250),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  await viewmodel.getVideo(ImageSource.camera);
                  viewmodel.uploadVideo(context);
                },
                child: customButton(context, 'Record Video', 50, 170),
              ),
            ],
          ),
        ),
      );
    });
  }
}
