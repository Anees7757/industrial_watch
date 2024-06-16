import 'package:flutter/material.dart';
import 'package:industrial_watch/views/widgets/custom_Button.dart';
import 'package:industrial_watch/views/widgets/custom_appbar.dart';
import 'package:lottie/lottie.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, 'Defect Monitoring'),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 30, 15, 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Lottie.asset(
              'assets/animations/defect_monitoring.json',
              height: 370,
              controller: _controller,
              repeat: true,
              reverse: true,
              animate: true,
              onLoaded: (composition) {
                _controller!
                  ..duration = composition.duration
                  ..repeat();
              },
            ),
            SizedBox(height: 30),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/single_defect_monitoring');
              },
              child: customButton(
                  context, 'Single Disc Monitoring', 60, double.infinity),
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/defect_monitoring');
              },
              child: customButton(
                  context, 'Batch Monitoring', 60, double.infinity),
            ),
          ],
        ),
      ),
    );
  }
}
