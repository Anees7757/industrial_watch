import 'dart:core';
import 'dart:io';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../constants/api_constants.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class BatchDetailsViewModel extends ChangeNotifier {
  Map<String, dynamic> batchDetails = {};

  bool loading = true;

  Future<void> getBatchDetails(BuildContext context, String id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Production/GetBatchDetails?batch_number=${Uri.encodeComponent(id)}',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        batchDetails = data;
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        //customSnackBar(context, error.toString());
      },
    );
  }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isAndroid) {
        // directory = await AndroidPathProvider.downloadsPath;
        // directory = await getApplicationDocumentsDirectory();
        // directory = Directory('/storage/emulated/0/Download')
        directory = await getExternalStorageDirectory();
        print("path>>>> $directory");
        // if (!await directory.path)
        //   directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory!.path;
  }

  var _progressList = <double>[];

  double currentProgress(int index) {
    try {
      return _progressList[index];
    } catch (e) {
      _progressList.add(0.0);
      return 0;
    }
  }

  Future<void> createDirectory() async {
    // String newDirectoryName = "Industrial Watch";
    // String newDirectoryPath = "${await getDownloadPath()}/$newDirectoryName";
    String newDirectoryPath = "${await getDownloadPath()}";

    // Check if the directory already exists
    if (await Directory(newDirectoryPath).exists()) {
      print("Directory already exists.");
    } else {
      // Create the directory if it doesn't exist
      await Directory(newDirectoryPath).create();
      print("Directory created.");
    }
  }

  void startForegroundService() async {
    await ForegroundService().start;
    print("Started service");
    // ForegroundServiceHandler.setServiceFunction(() {
    // });
  }

  void stopForegroundService() async {
    ForegroundService().stop();
    print("Service stopped");
  }

  void downloadImages(BuildContext context, String product_number,
      String batch_number, int index) async {
    final permission = await Permission.storage.request();

    if (!permission.isGranted) {
      await Permission.storage.request();
    }

    if (permission.isGranted) {
      customSnackBar(context, 'Downloading will start soon');
      createDirectory();
      await startForegroundService;
      NotificationService notificationService = NotificationService();

      final downloadUrl =
          '${ApiConstants.instance.baseurl}Production/GetDefectedImagesOfBatch?product_number=${Uri.encodeComponent(product_number)}&batch_number=${Uri.encodeComponent(batch_number)}';
      final fileName = '$batch_number.zip';

      final dio = Dio();
      try {
        await dio.get(downloadUrl).then((value) async {
          if (value.statusCode == 200 &&
              !(value.data.toString().contains('message'))) {
            // customSnackBar(context, 'Downloading will start soon');
            // await startForegroundService;
            String? dir = await getDownloadPath();
            dio.download(
              downloadUrl,
              "${dir!}/$product_number/$fileName",
              onReceiveProgress: ((count, total) async {
                if (total != 0) {
                  await Future.delayed(const Duration(seconds: 1), () async {
                    //_progressList[0] = (count / total);
                    if (count < total) {
                      notificationService.createNotification(
                          100,
                          ((count / total) * 100).toInt(),
                          index,
                          'Downloading...',
                          product_number,
                          batch_number);
                    }
                    if (count == total) {
                      // Navigator.pop(context);
                      await FlutterLocalNotificationsPlugin().cancel(index);
                      notificationService.createNotification(
                          100,
                          ((count / total) * 100).toInt(),
                          index,
                          'Downloading Completed',
                          product_number,
                          batch_number);
                      await ForegroundService().stop;
                      // customSnackBar(context, 'Successfully Downloaded');
                    }
                    notifyListeners();
                  });
                } else {
                  throw Exception('Total size is zero');
                }
              }),
            ).onError((error, stackTrace) {
              print(error);
              throw Exception('Error downloading file: $error');
            });
          } else {
            await ForegroundService().stop;
            if (value.statusCode == 200) {
              customSnackBar(context, value.data['message']);
            } else {
              throw (value.toString());
            }
          }
        });
      } catch (e) {
        await ForegroundService().stop;
        customSnackBar(context, 'Downloading failed, try again');
        print("error downloading file $e");
        await ForegroundService().stop;
      }
    } else {
      customSnackBar(context, 'Permission Denied');
    }
  }
}

class NotificationService {
  static final NotificationService _notificationService =
      NotificationService._internal();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidInitializationSettings _androidInitializationSettings =
      const AndroidInitializationSettings('ic_launcher');

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal() {
    init();
  }

  void init() async {
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: _androidInitializationSettings,
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void createNotification(int count, int i, int id, String title,
      String product_number, String batch_number) {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Download channel',
      'Download channel',
      channelDescription: 'Download notification',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: title == 'Downloading Completed' ? false : true,
      maxProgress: count,
      progress: i,
      styleInformation: BigTextStyleInformation(
        summaryText: title == 'Downloading Completed' ? null : '$i%',
        contentTitle: title,
        'defected_images_${product_number}_$batch_number.zip',
      ),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(
        id,
        title,
        'defected_images_${product_number}_$batch_number.zip',
        platformChannelSpecifics,
        payload: 'item x');
  }
}
