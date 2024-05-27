// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:industrial_watch/global/global.dart';
// import 'package:industrial_watch/view-models/supervisor/employee_monitoring_viewmodel.dart';
// import 'package:light_toast/light_toast.dart';
// import 'package:provider/provider.dart';
//
// import '../../../widgets/custom_appbar.dart';
//
// class EmployeeMonitoring1 extends StatefulWidget {
//   const EmployeeMonitoring1({Key? key}) : super(key: key);
//
//   @override
//   State<EmployeeMonitoring1> createState() => _EmployeeMonitoring1State();
// }
//
// class _EmployeeMonitoring1State extends State<EmployeeMonitoring1> {
// @override
// void dispose() {
//   Provider.of<EmployeeMonitoring1ViewModel>(context, listen: false)
//       .controller
//       .dispose();
//   Provider.of<EmployeeMonitoring1ViewModel>(context, listen: false)
//       .channel
//       .sink
//       .close();
//   super.dispose();
// }

// @override
// Widget build(BuildContext context) {
//   return PopScope(
//     onPopInvoked: (pop) {
//       Provider.of<EmployeeMonitoring1ViewModel>(context, listen: false)
//           .closeWebSocket();
//     },
//     child: ChangeNotifierProvider(
//       create: (_) => EmployeeMonitoring1ViewModel()..initialize(cameras.first),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         // appBar: customAppBar(context, '.'),
//         body: SafeArea(
//           child: Consumer<EmployeeMonitoring1ViewModel>(
//             builder: (context, viewModel, child) {
//               return FutureBuilder<void>(
//                 future: viewModel.initializeControllerFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return Stack(
//                       children: [
//                         CameraPreview(viewModel.controller),
//                         Positioned(
//                           top: 50,
//                           left: 50,
//                           child: Text(
//                             viewModel.pose,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 24,
//                               backgroundColor: Colors.black54,
//                             ),
//                           ),
//                         ),
//                       ],
//                     );
//                   } else {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//       ),
//     ),
//   );
//}

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => EmployeeMonitoringViewModel()..initialize(cameras.first),
//       child: Scaffold(
//         backgroundColor: Colors.black,
//         body: SafeArea(
//           child: Consumer<EmployeeMonitoringViewModel>(
//             builder: (context, viewModel, child) {
//               return FutureBuilder<void>(
//                 future: viewModel.initializeControllerFuture,
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.done) {
//                     return CameraPreview(viewModel.controller);
//                   } else {
//                     return Center(child: CircularProgressIndicator());
//                   }
//                 },
//               );
//             },
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//         floatingActionButton: Consumer<EmployeeMonitoringViewModel>(
//           builder: (context, viewModel, child) {
//             return Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 FloatingActionButton(
//                   backgroundColor: Colors.white,
//                   child: Icon(
//                     viewModel.isRecording
//                         ? Icons.stop
//                         : Icons.videocam_outlined,
//                     size: 32,
//                     color: Colors.red,
//                   ),
//                   onPressed: () {
//                     if (viewModel.isRecording) {
//                       viewModel.stopVideoRecording();
//                       Navigator.pop(context);
//                     } else {
//                       viewModel.startVideoRecording();
//                     }
//                   },
//                 ),
//                 SizedBox(height: 5),
//                 Text(
//                   viewModel.recordingDuration,
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 14,
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
