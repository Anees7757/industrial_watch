import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../widgets/custom_appbar.dart';

class ImagesDetailScreen extends StatefulWidget {
  String productNo;

  ImagesDetailScreen({super.key, required this.productNo});

  @override
  State<ImagesDetailScreen> createState() => _ImagesDetailScreenState();
}

class _ImagesDetailScreenState extends State<ImagesDetailScreen> {
  Map<String, dynamic> defects = {
    'Side1': {
      'time': '10:00 AM',
      'defect': 'Side Cut',
      'image': 'assets/images/defect.png',
    },
    'Front': {
      'time': '10:02 AM',
      'defect': 'Pin Hole',
      'image': 'assets/images/defect.png',
    },
    'Back': {
      'time': '10:05 AM',
      'defect': 'Pin Hole',
      'image': 'assets/images/defect.png',
    },
    'Side2': {
      'time': '10:07 AM',
      'defect': 'Side Cut',
      'image': 'assets/images/defect.png',
    },
    'Side3': {
      'time': '10:09 AM',
      'defect': 'No Issue',
      'image': 'assets/images/defect.png',
    },
    'Side4': {
      'time': '10:10 AM',
      'defect': 'No Issue',
      'image': 'assets/images/defect.png',
    },
  };

  List<Widget> images = [];

  @override
  void initState() {
    images.addAll(
      defects.keys.map((defectSide) {
        return Image.asset(defects[defectSide]['image']);
      }),
    );
    super.initState();
  }

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.productNo),
      body: Container(
        margin: const EdgeInsets.fromLTRB(0, 30, 0, 20),
        child: Column(
          children: [
            Text(defects.keys.elementAt(currentPage),
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                )),
            Text(defects[defects.keys.elementAt(currentPage)]['time']),
            CarouselSlider(
              items: images,
              options: CarouselOptions(
                height: 300,
                aspectRatio: 16 / 10,
                viewportFraction: 0.8,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentPage = index;
                  });
                },
                scrollDirection: Axis.horizontal,
              ),
            ),
            CarouselIndicator(
              width: 9,
              height: 9,
              count: images.length,
              index: currentPage,
              cornerRadius: 50,
              activeColor: Colors.black,
              color: const Color(0xFFD9D9D9),
              space: 6,
            ),
          ],
        ),
      ),
    );
  }
}
