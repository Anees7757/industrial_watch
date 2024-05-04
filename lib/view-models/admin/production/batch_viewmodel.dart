import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_foreground_service/flutter_foreground_service.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import '../../../contants/api_constants.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/error_screen.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:flutter_foreground_service/foreground_service.dart';

class BatchViewModel extends ChangeNotifier {
  List<dynamic> batches = [];

  bool loading = true;

  Future<void> getBatches(BuildContext context, String id) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path:
          'Production/GetAllBatches?product_number=${Uri.encodeComponent(id)}',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        batches = data;
        batches = batches.toSet().toList();
        loading = false;
        print(data);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        //customSnackBar(context, error.toString());
      },
    );
  }

  // downloadImages(BuildContext context) async {
  //   final permission = await Permission.storage.request();
  //
  //   if (permission.isGranted) {
  // List<List<int>> chunks = [];
  // int downloaded = 0;
  // customDialogBox(
  //     context,
  //     Container(
  //       margin: EdgeInsets.only(left: 18),
  //       child: Row(
  //         // mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           const CircularProgressIndicator(),
  //           SizedBox(
  //             width: 20,
  //           ),
  //           Text('Please wait\nDownloading...'),
  //         ],
  //       ),
  //     ),
  //     () {},
  //     () {},
  //     "");
  //
  // final url =
  //     '${ApiConstants.instance.baseurl}Production/GetAllDefectedImages';
  // final filename = 'defected_images.zip';
  // var httpClient = http.Client();
  // var request = http.Request('GET', Uri.parse(url));
  // var response = httpClient.send(request);
  // String? dir = await getDownloadPath();
  // debugPrint(dir! + '/' + filename);
  // response.asStream().listen((http.StreamedResponse r) {
  //   r.stream.listen((List<int> chunk) {
  //     debugPrint(
  //         'downloadPercentage: ${downloaded / r.contentLength! * 100}');
  //
  //     chunks.add(chunk);
  //     downloaded += chunk.length;
  //   }, onDone: () async {
  //     debugPrint(
  //         'downloadPercentage: ${downloaded / r.contentLength! * 100}');
  //     // Save the file
  //     File file = File('$dir/$filename');
  //     final Uint8List bytes = Uint8List(r.contentLength!);
  //     int offset = 0;
  //     for (List<int> chunk in chunks) {
  //       bytes.setRange(offset, offset + chunk.length, chunk);
  //       offset += chunk.length;
  //     }
  //     await file.writeAsBytes(bytes);
  //     Navigator.pop(context);
  //     customSnackBar(context, '.zip file Saved in Downloads');
  //     notifyListeners();
  //     return;
  //   });
  //});
  //   } else {
  //     customSnackBar(context, 'Permission Denied');
  //   }
  // }

  Future<String?> getDownloadPath() async {
    Directory? directory;
    try {
      if (Platform.isIOS) {
        directory = await getApplicationDocumentsDirectory();
      } else {
        directory = Directory('/storage/emulated/0/Download');
        if (!await directory.exists())
          directory = await getExternalStorageDirectory();
      }
    } catch (err) {
      print("Cannot get download folder path");
    }
    return directory?.path;
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
    String newDirectoryName = "Industrial Watch";
    String newDirectoryPath = "${await getDownloadPath()}/$newDirectoryName";

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
    // ForegroundServiceHandler.setServiceFunction(() {
    //   downloadImages(context, product_number, index);
    // });
    await ForegroundService().start;
    // ForegroundServiceHandler.notification;
    print("Started service");
  }

  void stopForegroundService() async {
    ForegroundService().stop();
    print("Service stopped");
  }

  void downloadImages(
      BuildContext context, String product_number, int index) async {
    final permission = await Permission.storage.request();

    if (permission.isGranted) {
      createDirectory();
      NotificationService notificationService = NotificationService();

      final downloadUrl =
          '${ApiConstants.instance.baseurl}Production/GetAllDefectedImages?product_number=${Uri.encodeComponent(product_number)}';
      final fileName = 'defected_items_$product_number.zip';

      final dio = Dio();
      try {
        await dio.get(downloadUrl).then((value) async {
          if (value.statusCode == 200 &&
              !(value.data.toString().contains('message'))) {
            customSnackBar(context, 'Downloading will start soon');
            await startForegroundService;
            String? dir = await getDownloadPath();
            dio.download(
              downloadUrl,
              "${dir!}/Industrial Watch/$fileName",
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
                          product_number);
                    }
                    if (count == total) {
                      // Navigator.pop(context);
                      await FlutterLocalNotificationsPlugin().cancel(index);
                      notificationService.createNotification(
                          100,
                          ((count / total) * 100).toInt(),
                          index,
                          'Downloading Completed',
                          product_number);
                      // await ForegroundService().stop();
                      // customSnackBar(context, 'Successfully Downloaded');
                    }
                    notifyListeners();
                  });
                } else {
                  throw ();
                }
              }),
            ).onError((error, stackTrace) async {
              throw ();
            });
          } else {
            if (value.statusCode == 200) {
              await ForegroundService().stop;
              customSnackBar(context, value.data['message']);
            } else {
              await ForegroundService().stop;
              throw (value.toString());
            }
          }
        });
      } catch (e) {
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

  void createNotification(
      int count, int i, int id, String title, String product_number) {
    //show the notifications.
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'Download channel',
      'Download channel',
      channelDescription: 'Download notification',
      channelShowBadge: false,
      importance: Importance.max,
      priority: Priority.high,
      onlyAlertOnce: true,
      showProgress: (title == 'Downloading Completed') ? false : true,
      maxProgress: count,
      colorized: true,
      // color: Colors.blue,
      progress: i,
      styleInformation: BigTextStyleInformation(
        summaryText: (title == 'Downloading Completed') ? null : '$i%',
        contentTitle: title,
        'defected_images_$product_number.zip',
      ),
    );
    var platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    _flutterLocalNotificationsPlugin.show(id, title,
        'defected_images_$product_number.zip', platformChannelSpecifics,
        payload: 'item x');
  }
}
