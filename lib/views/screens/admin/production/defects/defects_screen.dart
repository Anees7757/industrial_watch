import 'package:flutter/material.dart';

import '../../../../../widgets/custom_appbar.dart';
import 'imagesDetail_screen.dart';

class DefectsScreen extends StatefulWidget {
  String batchNo;
  String productNo;

  DefectsScreen({super.key, required this.batchNo, required this.productNo});

  @override
  State<DefectsScreen> createState() => _DefectsScreenState();
}

class _DefectsScreenState extends State<DefectsScreen> {
  List<String> defects = [
    'Side Cut',
    'Pinhole',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context, widget.batchNo),
      body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  height: 220,
                  margin: const EdgeInsets.fromLTRB(50, 20, 50, 20),
                  child: GridView.builder(
                    itemCount: 4,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 5,
                            mainAxisSpacing: 5),
                    itemBuilder: (BuildContext context, int index) {
                      if ((index == 3)) {
                        return InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => ImagesDetailScreen(
                                  productNo: widget.productNo,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            color: Colors.black.withOpacity(0.6),
                            child: const Center(
                                child: Text(
                              '+3',
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            )),
                          ),
                        );
                      } else {
                        return Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFFDDDDDD),
                            borderRadius: (index == 0)
                                ? const BorderRadius.only(
                                    topLeft: Radius.circular(20))
                                : (index == 1)
                                    ? const BorderRadius.only(
                                        topRight: Radius.circular(20))
                                    : const BorderRadius.only(
                                        bottomLeft: Radius.circular(20)),
                            image: const DecorationImage(
                              image: AssetImage(
                                'assets/images/defect.png',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          //child:
                          // const Icon(
                          //   Icons.filter_hdr_outlined,
                          //   color: Color(0xFF787878),
                          //   size: 35,
                          // ),
                        );
                      }
                    },
                  ),
                ),
              ),
              Text(
                widget.productNo,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const Text(
                '20 May 2023',
                style: TextStyle(fontSize: 16, color: Color(0xFF616161)),
              ),
              const SizedBox(height: 30),
              const Row(
                children: [
                  Text(
                    'Defects',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 3),
              Expanded(
                child: ListView.builder(
                    itemCount: defects.length,
                    itemBuilder: (context, index) {
                      return Row(children: [
                        const SizedBox(width: 30),
                        const Text(
                          "\u2022",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFF616161)),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Text(
                            defects[index],
                            style: const TextStyle(
                                fontSize: 16, color: Color(0xFF616161)),
                          ),
                        )
                      ]);
                    }),
              ),
            ],
          )),
    );
  }
}
