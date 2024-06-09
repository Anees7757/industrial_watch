import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:industrial_watch/constants/api_constants.dart';
import 'package:light_toast/light_toast.dart';

import '../../views/widgets/custom_dialogbox.dart';

class EmployeeMonitoringViewModel extends ChangeNotifier {
  // late CameraController controller;
  // bool isRecording = false;
  // late Future<void> _initializeControllerFuture;
  // String recordingDuration = "";
  // Timer? _timer;
  // int _start = 0;

  // late IOWebSocketChannel channel;
  // String _pose = "";
  //
  // String get pose => _pose;
  //
  // Future<void> get initializeControllerFuture => _initializeControllerFuture;
  //
  // Future<void> initialize(CameraDescription camera) async {
  //   controller = CameraController(camera, ResolutionPreset.high);
  //   _initializeControllerFuture = controller.initialize();

  // Connect to WebSocket server
  // channel = IOWebSocketChannel.connect('ws://192.168.43.192:8765');
  //
  // // Listen for pose detection results from the server
  // channel.stream.listen((message) {
  //   _pose = message;
  //   notifyListeners();
  // });

  //   await _initializeControllerFuture;
  //   // _captureFrames();
  // }

  // Future<void> _captureFrames() async {
  //   while (true) {
  //     try {
  //       // Capture frame
  //       final XFile file = await controller.takePicture();
  //       final bytes = await file.readAsBytes();
  //
  //       // Send frame to server
  //       channel.sink.add(bytes);
  //     } catch (e) {
  //       print(e);
  //     }
  //
  //     await Future.delayed(Duration(milliseconds: 100));
  //   }
  // }

  // void closeWebSocket() {
  //   channel.sink.close();
  //   print('WebSocket connection closed');
  // }
  // void startTimer() {
  //   const oneSec = const Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       _start++;
  //       int minutes = _start ~/ 60;
  //       int seconds = _start % 60;
  //       recordingDuration =
  //           "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  //       notifyListeners();
  //     },
  //   );
  // }
  //
  // void stopTimer() {
  //   _timer?.cancel();
  //   _start = 0;
  //   recordingDuration = "";
  // }
  //
  // Future<void> startVideoRecording() async {
  //   if (!controller.value.isInitialized) {
  //     return;
  //   }
  //
  //   final directory = await getApplicationDocumentsDirectory();
  //   final videoPath = join(directory.path, '${DateTime.now()}.mp4');
  //
  //   try {
  //     await controller.startVideoRecording();
  //     isRecording = true;
  //     startTimer();
  //     notifyListeners();
  //   } on CameraException catch (e) {
  //     print('Error starting video recording: $e');
  //   }
  // }
  //
  // Future<void> stopVideoRecording() async {
  //   if (!controller.value.isRecordingVideo) {
  //     return;
  //   }
  //
  //   try {
  //     final videoFile = await controller.stopVideoRecording();
  //     final videoPath = videoFile.path;
  //     isRecording = false;
  //     Toast.show(
  //       'Please wait! video is uploading',
  //       borderRadius: 30,
  //       duration: Duration(seconds: 3),
  //     );
  //     stopTimer();
  //     print('Video recorded to: $videoPath');
  //     notifyListeners();
  //   } on CameraException catch (e) {
  //     print('Error stopping video recording: $e');
  //   }
  // }
  //
  // @override
  // void dispose() {
  //   controller?.dispose();
  //   _timer?.cancel();
  //   super.dispose();
  // }

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
