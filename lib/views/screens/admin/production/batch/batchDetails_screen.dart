import 'package:flutter/material.dart';
import 'package:industrial_watch/views/screens/admin/production/batch/productDetails_screen.dart';
import 'package:provider/provider.dart';

import '../../../../../view-models/admin/production/production_viewmodel.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_textfield.dart';

class BatchDetailsScreen extends StatefulWidget {
  Map<String, dynamic> batch;

  BatchDetailsScreen({super.key, required this.batch});

  @override
  State<BatchDetailsScreen> createState() => _BatchDetailsScreenState();
}

class _BatchDetailsScreenState extends State<BatchDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context, widget.batch.keys.first),
      body: Consumer<ProductionViewModel>(
        builder: (context, dataProvider, child) {
          return Container(
            margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: [
                CustomTextField(
                  controller: dataProvider.searchController,
                  hintText: 'Search ',
                  action: TextInputAction.search,
                  textInputType: TextInputType.number,
                  isFocus: false,
                ),
                const SizedBox(height: 10),
                widget.batch.values.isEmpty
                    ? const Center(
                        child: Text('No Product'),
                      )
                    : dataProvider.filteredBatches.isEmpty
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  widget.batch.values.elementAt(0).length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          widget.batch.values
                                              .elementAt(0)[index],
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ProductDetailScreen(
                                                    batchNo:
                                                        widget.batch.keys.first,
                                                    productNo: widget
                                                        .batch.values
                                                        .elementAt(0)[index]),
                                          ),
                                        );
                                      },
                                    ),
                                    (index !=
                                            widget.batch.values
                                                    .elementAt(0)
                                                    .length -
                                                1)
                                        ? const Divider(
                                            height: 5,
                                            thickness: 1,
                                            color: Color(0xFFBFBFBF),
                                          )
                                        : const SizedBox(),
                                  ],
                                );
                              },
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              itemCount:
                                  widget.batch.values.elementAt(0).length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          widget.batch.values
                                              .elementAt(0)[index],
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                      onTap: () {
                                        // Navigator.of(context).push(
                                        //   MaterialPageRoute(
                                        //     builder: (context) => SectionDetailsScreen(
                                        //       section: _sectionsViewModel!.sections[index],
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                    ),
                                    (index !=
                                            widget.batch.values
                                                    .elementAt(0)
                                                    .length -
                                                1)
                                        ? const Divider(
                                            height: 5,
                                            thickness: 1,
                                            color: Color(0xFFBFBFBF),
                                          )
                                        : const SizedBox(),
                                  ],
                                );
                              },
                            ),
                          ),
              ],
            ),
          );
        },
      ),
    );
  }
}
