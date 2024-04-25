import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'global/global.dart';
import 'utils/providers.dart';
import 'utils/routes.dart';
import 'utils/shared_prefs/shared_prefs.dart';
import 'views/widgets/ipDialog.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DataSharedPrefrences.init();
  String userDataString = DataSharedPrefrences.getUser();
  if (userDataString.isNotEmpty) {
    userData = jsonDecode(userDataString);
  }
  debugPrint(userDataString);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        child: MaterialApp(
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
              : '/${userData['role'].toString().toLowerCase()}',
          routes: routes,
        ),
      ),
    );
  }
}
