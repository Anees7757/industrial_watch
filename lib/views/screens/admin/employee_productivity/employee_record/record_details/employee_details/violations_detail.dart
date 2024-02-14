import 'package:flutter/material.dart';
import 'package:industrial_watch/global/global.dart';
import 'package:industrial_watch/models/violation_model.dart';

class ViolationDetailScreen extends StatefulWidget {
  int violationId;

  ViolationDetailScreen({super.key, required this.violationId});

  @override
  State<ViolationDetailScreen> createState() => _ViolationDetailScreenState();
}

class _ViolationDetailScreenState extends State<ViolationDetailScreen> {
  int currentPage = 0;
  Violation? violation;
  String? employeeName;

  // List<Widget> images = [];

  @override
  void initState() {
    super.initState();
    violation =
        violations.where((element) => element.id == widget.violationId).first;
    employeeName = employees
        .where((element) =>
            element.id ==
            violations
                .where((element) => element.id == widget.violationId)
                .first
                .empId)
        .first
        .name;
    // images.addAll(
    //   violation!.images.map((defectSide) {
    //     return Image.asset(defectSide);
    //   }),
    //);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(employeeName!),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(30, 50, 30, 20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage(violation!.images.first),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            // CarouselSlider(
            //   items: images,
            //   options: CarouselOptions(
            //     height: 300,
            //     aspectRatio: 16 / 10,
            //     viewportFraction: 0.8,
            //     initialPage: 0,
            //     enableInfiniteScroll: true,
            //     reverse: false,
            //     autoPlay: false,
            //     autoPlayInterval: const Duration(seconds: 3),
            //     autoPlayAnimationDuration: const Duration(milliseconds: 800),
            //     autoPlayCurve: Curves.fastOutSlowIn,
            //     enlargeCenterPage: true,
            //     enlargeFactor: 0.3,
            //     onPageChanged: (index, reason) {
            //       setState(() {
            //         currentPage = index;
            //       });
            //     },
            //     scrollDirection: Axis.horizontal,
            //   ),
            // ),
            // CarouselIndicator(
            //   width: 9,
            //   height: 9,
            //   count: images.length,
            //   index: currentPage,
            //   cornerRadius: 50,
            //   activeColor: Colors.black,
            //   color: const Color(0xFFD9D9D9),
            //   space: 6,
            // ),
            const SizedBox(height: 30),
            Text(violation!.date),
            Text(violation!.time),
            const SizedBox(height: 50),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Violated Rules',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  )),
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('\u2022 ${violation!.title}',
                    style: const TextStyle())),
          ],
        ),
      ),
    );
  }
}
