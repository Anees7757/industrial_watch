import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view-models/admin/production/production_viewmodel.dart';
import '../../../../../view-models/admin/production/products_viewmodel.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_textfield.dart';
import '../defects/defects_screen.dart';

class ProductsScreen extends StatefulWidget {
  String batchNo;

  ProductsScreen({super.key, required this.batchNo});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: customAppBar(context, widget.batchNo),
      body: Consumer<ProductsViewModel>(
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
                dataProvider.batches[widget.batchNo].isEmpty
                    ? const Center(
                        child: Text('No Product'),
                      )
                    : dataProvider.filteredBatches[widget.batchNo] == null
                        ? Expanded(
                            child: ListView.builder(
                              itemCount:
                                  dataProvider.batches[widget.batchNo].length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          dataProvider.batches[widget.batchNo]
                                              [index],
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DefectsScreen(
                                              batchNo: widget.batchNo,
                                              productNo: dataProvider
                                                      .batches[widget.batchNo]
                                                  [index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    (index !=
                                            dataProvider.batches[widget.batchNo]
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
                                  dataProvider.batches[widget.batchNo].length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          dataProvider.batches[widget.batchNo]
                                              [index],
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                      onTap: () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => DefectsScreen(
                                              batchNo: widget.batchNo,
                                              productNo: dataProvider
                                                      .batches[widget.batchNo]
                                                  [index],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    (index !=
                                            dataProvider.batches[widget.batchNo]
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
