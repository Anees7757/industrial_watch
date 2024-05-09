import 'dart:convert';
import 'package:floating_draggable_widget/floating_draggable_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:industrial_watch/views/widgets/ipDialog.dart';
import 'package:provider/provider.dart';
import 'global/global.dart';
import 'utils/providers.dart';
import 'utils/routes.dart';
import 'utils/shared_prefs/shared_prefs.dart';
import 'views/widgets/toast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  await DataSharedPrefrences.init();
  String userDataString = DataSharedPrefrences.getUser();
  if (userDataString.isNotEmpty) {
    userData = jsonDecode(userDataString);
  }
  debugPrint(userDataString);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (FocusManager.instance.primaryFocus?.hasPrimaryFocus ?? false) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: MultiProvider(
        providers: providers,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Industrial Watch',
          theme: ThemeData(
            useMaterial3: false,
            primaryColor: Colors.blue,
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            }),
            scaffoldBackgroundColor: Color(0xFFF7F7F7),
          ),
          initialRoute: userData.isEmpty
              ? '/login'
              : '/${userData['user_role'].toString().toLowerCase()}',
          routes: routes,
          builder: (context, child) {
            return FloatingDraggableWidget(
              mainScreenWidget: child!,
              floatingWidget: Opacity(
                opacity: 0.3,
                child: FloatingActionButton(
                  onPressed: () {
                    setState(() {
                      showIPDialog();
                    });
                  },
                  child: const Icon(
                    Icons.change_circle_outlined,
                    size: 32,
                  ),
                ),
              ),
              autoAlign: true,
              isDraggable: true,
              deleteWidget: cancelButton,
              dy: MediaQuery.of(context).size.height / 2,
              dx: MediaQuery.of(context).size.width - 45,
              floatingWidgetHeight: 45,
              floatingWidgetWidth: 45,
            );
          },
        ),
      ),
    );
  }
}
