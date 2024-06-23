import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../view-models/supervisor/mark_attendance_viewmodel.dart';
import '../../widgets/custom_Button.dart';
import '../../widgets/custom_appbar.dart';

class MarkAttendance extends StatelessWidget {
  const MarkAttendance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MarkAttendanceViewModel>(
      builder: (context, viewModel, child) {
        return WillPopScope(
          onWillPop: () async {
            viewModel.clearSelectedImage();
            return true;
          },
          child: Scaffold(
            appBar: customAppBar(context, 'Mark Attendance'),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _imagePickerBox(context, viewModel.selectedImage, () async {
                    viewModel.showBottomSheet(context);
                  }),
                  SizedBox(height: 40),
                  if (viewModel.selectedImage != null) ...[
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () async {
                        await viewModel.uploadImage(context);
                      },
                      child: customButton(context, 'Mark Attendance', 50, 180),
                    )
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imagePickerBox(
      BuildContext context, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 180,
            height: 200,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              image: image != null
                  ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                  : null,
            ),
            child: image == null
                ? const Icon(
                    Icons.add_a_photo,
                    color: Colors.grey,
                    size: 32,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
