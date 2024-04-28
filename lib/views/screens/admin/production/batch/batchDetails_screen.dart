import 'package:flutter/material.dart';
import 'package:industrial_watch/utils/word_capitalize.dart';
import 'package:provider/provider.dart';
import '../../../../../view-models/admin/production/batchDetails_viewmodel.dart';

class BatchDetailScreen extends StatefulWidget {
  String batchNo;
  String product_number;
  int index;

  BatchDetailScreen(
      {super.key,
      required this.batchNo,
      required this.product_number,
      required this.index});

  @override
  State<BatchDetailScreen> createState() => _BatchDetailScreenState();
}

class _BatchDetailScreenState extends State<BatchDetailScreen> {
  BatchDetailsViewModel? _batchDetailViewModel;

  @override
  void initState() {
    _batchDetailViewModel =
        Provider.of<BatchDetailsViewModel>(context, listen: false);
    _batchDetailViewModel!.getBatchDetails(context, widget.batchNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('${widget.batchNo}'.capitalize()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: Consumer<BatchDetailsViewModel>(
        builder: (context, dataProvider, child) {
          return Provider.of<BatchDetailsViewModel>(context, listen: true)
                  .loading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Provider.of<BatchDetailsViewModel>(context, listen: true)
                      .batchDetails
                      .isEmpty
                  ? const Center(
                      child: Text('Something went wrong'),
                    )
                  : Container(
                      margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                      child: Column(
                        children: [
                          customProductCom(
                              'Status', dataProvider.batchDetails['status']),
                          const SizedBox(height: 25),
                          customProductCom(
                              'Dated', dataProvider.batchDetails['date']),
                          const SizedBox(height: 15),
                          customProductCom(
                              'Total Pieces',
                              dataProvider.batchDetails['total_piece']
                                  .toString()),
                          const SizedBox(height: 15),
                          customProductCom(
                              'Defected Pieces',
                              dataProvider.batchDetails['defected_piece']
                                  .toString()),
                          const SizedBox(height: 15),
                          customProductCom(
                              'Rejection Tolerance',
                              dataProvider.batchDetails['rejection_tolerance']
                                      .toString() +
                                  '%'),
                          const SizedBox(height: 15),
                          customProductCom('Total Yield',
                              '${dataProvider.batchDetails['batch_yield']}%'),
                        ],
                      ),
                    );
        },
      ),
      floatingActionButton:
          !Provider.of<BatchDetailsViewModel>(context, listen: true).loading
              ? FloatingActionButton.extended(
                  onPressed: () {
                    _batchDetailViewModel!.downloadImages(
                      context,
                      widget.product_number,
                      widget.batchNo,
                      widget.index,
                    );
                  },
                  backgroundColor: Colors.grey[800],
                  label: Text('Download Images'),
                  icon: Icon(Icons.cloud_download_rounded),
                )
              : SizedBox(),
    );
  }
}

customProductCom(String title, dynamic value) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Text('$title:',
          style: const TextStyle(
            color: Color(0xFF616161),
            fontSize: 18,
          )),
      SizedBox(
        width: 20,
      ),
      title.toLowerCase() != 'status'
          ? Text(
              (value.isEmpty || value == 'null' || value == '-1.0%')
                  ? '--'
                  : '$value',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            )
          : Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: value == 1
                    ? Colors.red.shade800
                    : value == 0
                        ? Colors.green.shade800
                        : Colors.grey.shade500,
              ),
              child: Center(
                child: Text(
                  value == 1
                      ? 'Rejected'
                      : value == 0
                          ? 'Accepted'
                          : 'Pending',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
    ],
  );
}
