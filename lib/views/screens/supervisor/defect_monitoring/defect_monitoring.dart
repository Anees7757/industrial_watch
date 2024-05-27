import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/view-models/supervisor/defect_monitoring_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_appbar.dart';

class DefectMonitoring extends StatefulWidget {
  const DefectMonitoring({Key? key}) : super(key: key);

  @override
  State<DefectMonitoring> createState() => _DefectMonitoringState();
}

class _DefectMonitoringState extends State<DefectMonitoring> {
  @override
  Widget build(BuildContext context) {
    return Consumer<DefectMonitoringViewModel>(
        builder: (context, viewmodel, child) {
      return Scaffold(
        appBar: customAppBar(context, 'Defect Monitoring'),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () async {
                  await viewmodel.getVideo(ImageSource.gallery);
                  // viewmodel.uploadVideo(context);
                },
                child:
                    customButton(context, 'Choose Video from Gallery', 50, 250),
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: () async {
                  await viewmodel.getVideo(ImageSource.camera);
                  // viewmodel.uploadVideo(context);
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
