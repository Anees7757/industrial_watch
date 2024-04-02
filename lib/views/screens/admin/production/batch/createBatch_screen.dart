import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view-models/admin/production/createBatch_viewModel.dart';
import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_appbar.dart';
import '../../../../widgets/custom_textfield.dart';

class CreateBatchScreen extends StatefulWidget {
  const CreateBatchScreen({super.key});

  @override
  State<CreateBatchScreen> createState() => _CreateBatchScreenState();
}

class _CreateBatchScreenState extends State<CreateBatchScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<CreateBatchViewModel>(
        builder: (context, dataProvider, child) {
      return PopScope(
        onPopInvoked: (pop) async {
          dataProvider.batchController.clear();
          dataProvider.toleranceController.clear();
          dataProvider.rawMaterials.clear();
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: customAppBar(context, 'Create Batch'),
          body: Container(
            margin: const EdgeInsets.fromLTRB(20, 30, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomTextField(
                  controller: dataProvider.batchController,
                  hintText: 'Batch#',
                  action: TextInputAction.next,
                  textInputType: TextInputType.number,
                  isFocus: true,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: dataProvider.anglesController,
                  hintText: 'No. of angles',
                  action: TextInputAction.next,
                  textInputType: TextInputType.number,
                  isFocus: true,
                ),
                const SizedBox(height: 8),
                CustomTextField(
                  controller: dataProvider.toleranceController,
                  hintText: 'Tolerance%',
                  action: TextInputAction.done,
                  textInputType: TextInputType.number,
                  isFocus: false,
                ),
                const SizedBox(height: 30),
                const Text('Raw Materials',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    )),
                const SizedBox(height: 10),
                Expanded(
                  child: DataTable(
                    columnSpacing: 30,
                    headingRowColor: MaterialStateColor.resolveWith(
                        (states) => Colors.yellow.withOpacity(0.2)),
                    columns: const [
                      DataColumn(
                        numeric: true,
                        label: Text('#'),
                      ),
                      DataColumn(
                        label: Text('Name'),
                      ),
                      DataColumn(
                        label: Text('Quantity'),
                      ),
                      DataColumn(
                        label: Text('Quantity\nper item'),
                      ),
                    ],
                    rows: dataProvider.rawMaterials
                        .map(
                          (item) => DataRow(
                            cells: [
                              DataCell(Text(item['number']!)),
                              DataCell(Text(item['name']!)),
                              DataCell(Text(item['quantity']!)),
                              DataCell(Text(item['quantityPerItem']!)),
                            ],
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  dataProvider.addSection(context);
                },
                child:
                    customButton(context, 'Add Batch', 56.79, double.infinity),
              ),
            ),
          ),
        ),
      );
    });
  }
}
