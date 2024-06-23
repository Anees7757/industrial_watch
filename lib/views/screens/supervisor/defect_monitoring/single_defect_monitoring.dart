import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';

import '../../../../view-models/supervisor/defect_monitoring_viewmodel.dart';
import '../../../../view-models/supervisor/single_defect_monitoring_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_appbar.dart';

class SingleDefectMonitoring extends StatefulWidget {
  const SingleDefectMonitoring({super.key});

  @override
  State<SingleDefectMonitoring> createState() => _SingleDefectMonitoringState();
}

class _SingleDefectMonitoringState extends State<SingleDefectMonitoring> {
  @override
  void initState() {
    Provider.of<DefectMonitoringViewModel>(context, listen: false)
        .getProducts(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SingleDefectMonitoringViewModel>(
        builder: (context, viewmodel, child) {
      return WillPopScope(
        onWillPop: () async {
          viewmodel.clearImages();
          return true;
        },
        child: Scaffold(
          appBar: customAppBar(context, 'Defect Monitoring'),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _imagePickerBox(context, 'Front', viewmodel.frontImage,
                        () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          viewmodel.frontImage = File(pickedFile.path);
                        });
                      }
                    }),
                    _imagePickerBox(context, 'Back', viewmodel.backImage,
                        () async {
                      final pickedFile = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        setState(() {
                          viewmodel.backImage = File(pickedFile.path);
                        });
                      }
                    }),
                    _sideImagePickerBox(context, 'Sides', viewmodel.sideImages,
                        () async {
                      final pickedFiles = await ImagePicker().pickMultiImage();
                      if (pickedFiles.isNotEmpty &&
                          pickedFiles.length + viewmodel.sideImages.length <=
                              4) {
                        setState(() {
                          viewmodel.sideImages.addAll(
                              pickedFiles.map((file) => File(file.path)));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('You can only pick up to 4 side images.'),
                          ),
                        );
                      }
                    })
                  ],
                ),
                SizedBox(height: 60),
                (viewmodel.frontImage != null &&
                        viewmodel.backImage != null &&
                        viewmodel.sideImages.isNotEmpty)
                    ? InkWell(
                        onTap: () {
                          viewmodel.processImages(context);
                        },
                        child:
                            customButton(context, 'Start Monitoring', 50, 180),
                      )
                    : SizedBox()
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _imagePickerBox(
      BuildContext context, String label, File? image, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
              image: image != null
                  ? DecorationImage(image: FileImage(image), fit: BoxFit.cover)
                  : null,
            ),
            child: image == null
                ? const Icon(Icons.add_a_photo, color: Colors.grey)
                : null,
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }

  Widget _sideImagePickerBox(BuildContext context, String label,
      List<File> images, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: images.isEmpty
                ? const Icon(Icons.add_a_photo, color: Colors.grey)
                : GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 2,
                      mainAxisSpacing: 2,
                    ),
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: FileImage(images[index]),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          const SizedBox(height: 8),
          Text(label),
        ],
      ),
    );
  }
}
