import 'package:flutter/material.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';
import 'package:industrial_watch/view-models/admin/production/batch_viewmodel.dart';
import 'package:industrial_watch/views/screens/admin/production/batch/createBatch_screen.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_dialogbox.dart';
import 'batchDetails_screen.dart';

class BatchScreen extends StatefulWidget {
  Map<String, dynamic> product;
  int index;

  BatchScreen({super.key, required this.product, required this.index});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  BatchViewModel? _batchViewModel;

  @override
  void initState() {
    _batchViewModel = Provider.of<BatchViewModel>(context, listen: false);
    _batchViewModel!.getBatches(context, widget.product['product_number']);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _batchViewModel!.getBatches(context, widget.product['product_number']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('${widget.product['name']}'.capitalize()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Consumer<BatchViewModel>(
          builder: (context, dataProvider, child) {
            return Provider.of<BatchViewModel>(context, listen: true).loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Provider.of<BatchViewModel>(context, listen: true)
                        .batches
                        .isEmpty
                    ? const Center(
                        child: Text('No Batch Found'),
                      )
                    : Column(
                        children: [
                          // CustomTextField(
                          //   controller: dataProvider.searchController,
                          //   hintText: 'Search',
                          //   action: TextInputAction.search,
                          //   textInputType: TextInputType.number,
                          //   isFocus: false,
                          // ),
                          Container(
                            margin: const EdgeInsets.fromLTRB(0, 10, 15, 0),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  dataProvider.downloadImages(
                                      context,
                                      widget.product['product_number'],
                                      widget.index);
                                },
                                icon: const Icon(
                                  Icons.cloud_download_rounded,
                                  color: Colors.white,
                                ),
                                label: const Text(
                                  'Defected Batches',
                                  style: TextStyle(
                                    color: Colors.white, // Dark gray color
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Expanded(
                            child: ListView.builder(
                              itemCount: dataProvider.batches.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          dataProvider.batches[index]
                                              ['batch_number'],
                                          overflow: TextOverflow.visible,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w500,
                                          )),
                                      trailing: const Icon(
                                          Icons.arrow_forward_ios_rounded),
                                      tileColor: dataProvider.batches[index]
                                                  ['status'] ==
                                              1
                                          ? Colors.red.withOpacity(0.2)
                                          : dataProvider.batches[index]
                                                      ['status'] ==
                                                  0
                                              ? Colors.green.withOpacity(0.2)
                                              : Colors.transparent,
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              horizontal: 15),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                BatchDetailScreen(
                                              batchNo:
                                                  dataProvider.batches[index]
                                                      ['batch_number'],
                                              product_number: widget
                                                  .product['product_number'],
                                              index: index,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      child: const Divider(
                                        height: 0,
                                        thickness: 1,
                                        color: Color(0xFFBFBFBF),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreateBatchScreen(product: widget.product),
                ),
              ).whenComplete(() => _refreshRawMaterials);
            },
            child: customButton(context, 'Create Batch', 52, double.infinity),
          ),
        ),
      ),
    );
  }
}
