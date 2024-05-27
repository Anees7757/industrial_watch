import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart';
import 'package:light_toast/light_toast.dart';
import 'package:web_socket_channel/io.dart';
import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import '../../views/widgets/custom_dialogbox.dart';

class DefectMonitoringViewModel extends ChangeNotifier {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedVideo;

  Future<void> getVideo(ImageSource imageSource) async {
    final XFile? video = await _picker.pickVideo(
      source: imageSource,
      preferredCameraDevice: CameraDevice.rear,
    );
    if (video != null) {
      print('Video selected: ${video.path}');
      _selectedVideo = video;
      notifyListeners();
    }
  }

  Future<void> uploadVideo(BuildContext context) async {
    if (_selectedVideo == null) {
      Toast.show(
        'Unable to fetch video',
        borderRadius: 30,
        duration: Duration(seconds: 3),
      );
      return;
    }

    // Toast.show(
    //   context: context,
    //   'Please wait! video is uploading',
    //   borderRadius: 30,
    //   duration: Duration(seconds: 3),
    // );

    customDialogBox(
        context,
        Container(
          margin: EdgeInsets.only(left: 18),
          child: Row(
            children: [
              const CircularProgressIndicator(),
              SizedBox(
                width: 20,
              ),
              const Text('Please wait...'),
            ],
          ),
        ),
        () {},
        () {},
        "");

    try {
      String uploadUrl =
          '${ApiConstants.instance.baseurl}Automation/PredictEmployeeViolation';
      FormData formData = FormData.fromMap({
        'files': await MultipartFile.fromFile(_selectedVideo!.path,
            filename: 'video.mp4'),
      });

      Dio dio = Dio();

      Response response = await dio.post(uploadUrl, data: formData);

      if (response.statusCode == 200) {
        print('Video uploaded successfully');
        Toast.show(
          'Video uploaded successfully',
          borderRadius: 30,
          duration: Duration(seconds: 3),
        );
        Navigator.pop(context);
        _selectedVideo = null;
        notifyListeners();
      } else {
        String message = response.data['message'] ?? 'Failed to upload video';
        print(
            'Failed to upload video. Status code: ${response.statusCode}, message: $message');
        Toast.show(
          message,
          borderRadius: 30,
          duration: Duration(seconds: 3),
        );
        _selectedVideo = null;
      }
      notifyListeners();
    } on DioError catch (e) {
      Navigator.pop(context);

      String errorMessage;
      if (e.response != null) {
        errorMessage = 'Error uploading video: ${e.message}';
        print('Status code: ${e.response?.statusCode}');
        print('Data: ${e.response?.data}');
      } else {
        errorMessage = 'Error uploading video: ${e.message}';
      }

      print(errorMessage);
      Toast.show(
        e.response?.data['message'],
        borderRadius: 30,
        duration: Duration(seconds: 3),
      );
      _selectedVideo = null;
      notifyListeners();
    } catch (e) {
      Navigator.pop(context);
      String errorMessage = 'Unexpected error: $e';
      print(errorMessage);
      Toast.show(
        'Something went wrong',
        borderRadius: 30,
        duration: Duration(seconds: 3),
      );
      _selectedVideo = null;
      notifyListeners();
    }
  }
}
