import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:industrial_watch/views/widgets/custom_dialogbox.dart';
import 'package:provider/provider.dart';

import '../../../view-models/auth/login_viewmodel.dart';
import '../../widgets/custom_Button.dart';
import '../../widgets/custom_textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark),
    );
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                Image.asset('assets/images/industry.png'),
                const Text("Industrial Watch",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const Text("An AI based monitoring system"),
                const SizedBox(height: 150),
                Consumer<LoginViewModel>(builder: (context, viewModel, child) {
                  return CustomTextField(
                    controller: viewModel.usernameController,
                    hintText: 'Username',
                    action: TextInputAction.next,
                    textInputType: TextInputType.text,
                    isFocus: false,
                  );
                }),
                const SizedBox(height: 10),
                Consumer<LoginViewModel>(builder: (context, viewModel, child) {
                  return CustomTextField(
                    controller: viewModel.passwordController,
                    hintText: 'Password',
                    action: TextInputAction.done,
                    textInputType: TextInputType.text,
                    isFocus: false,
                  );
                }),
                const SizedBox(height: 50),
                GestureDetector(
                  onTap: () {
                    Provider.of<LoginViewModel>(context, listen: false)
                        .login(context);
                  },
                  child: customButton(context, 'Login', 52, double.infinity),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
