import 'package:carousel_indicator/carousel_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/employee_productivity/employee_record/employee_details/violationsDetail_viewmodel.dart';
import 'package:provider/provider.dart';

import '../../../../constants/api_constants.dart';

class ViolationDetailScreen extends StatefulWidget {
  int violationId;

  ViolationDetailScreen({super.key, required this.violationId});

  @override
  State<ViolationDetailScreen> createState() => _ViolationDetailScreenState();
}

class _ViolationDetailScreenState extends State<ViolationDetailScreen> {
  int currentPage = 0;
  ViolationsDetailViewModel? _violationsDetailViewModel;

  fetchData() async {
    await Future.wait([
      _violationsDetailViewModel!
          .getViolationsDetail(context, widget.violationId),
    ]);
  }

  bool isFirstTime = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (isFirstTime) {
      _violationsDetailViewModel =
          Provider.of<ViolationsDetailViewModel>(context);
      isFirstTime = false;
      fetchData();
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Violations'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Consumer<ViolationsDetailViewModel>(
          builder: (context, provider, child) {
        List<Widget> images = [];
        // if (provider.violations['images'].isEmpty) {
        // for (int i = 0; i < 3; i++) {
        //   images.add(
        //     Container(
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(15),
        //         image: DecorationImage(
        //           image: AssetImage(
        //             provider.getDummyImagePath(
        //               provider.violations['rule_name']
        //                   .toString()
        //                   .toLowerCase(),
        //             ),
        //           ),
        //           fit: BoxFit.cover,
        //         ),
        //       ),
        //     ),
        //   );
        // }
        // } else {
        for (var i in provider.violations['images']) {
          images.add(
            Container(
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: NetworkImage(
                      "${ApiConstants.instance.baseurl}ViolationImages/${i['image_url']}"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }
        // }

        return Provider.of<ViolationsDetailViewModel>(context, listen: true)
                .loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : provider.violations.isEmpty
                ? const Center(
                    child: Text('Something went wrong'),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Container(
                        //   height: 200,
                        //   width: 200,
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(15),
                        //     image: DecorationImage(
                        //       image: AssetImage(provider.violations),
                        //       fit: BoxFit.cover,
                        //     ),
                        //   ),
                        // ),
                        CarouselSlider(
                          items: images,
                          options: CarouselOptions(
                            height: 180,
                            aspectRatio: 16 / 10,
                            viewportFraction: 0.8,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            reverse: false,
                            autoPlay: false,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                const Duration(milliseconds: 800),
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
                        const SizedBox(height: 10),
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
                        const SizedBox(height: 30),
                        Text(provider.violations['date']
                            .toString()
                            .split('00')[0]),
                        Text(provider.violations['images'][0]['capture_time']),
                        const SizedBox(height: 50),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Violated Rule/s',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                                '\u2022 ${provider.violations['rule_name']}',
                                style: const TextStyle())),
                      ],
                    ),
                  );
      }),
    );
  }
}
