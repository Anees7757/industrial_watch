import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view-models/admin/production/createBatch_viewmodel.dart';
import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_textfield.dart';
import 'chooseStock_screen.dart';

class CreateBatchScreen extends StatefulWidget {
  Map<String, dynamic> product;

  CreateBatchScreen({super.key, required this.product});

  @override
  State<CreateBatchScreen> createState() => _CreateBatchScreenState();
}

class _CreateBatchScreenState extends State<CreateBatchScreen> {
  CreateBatchViewmodel? _createBatchViewmodel;

  @override
  void initState() {
    _createBatchViewmodel =
        Provider.of<CreateBatchViewmodel>(context, listen: false);
    _createBatchViewmodel!
        .getRawMaterials(context, widget.product['product_number']);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _createBatchViewmodel!
        .getRawMaterials(context, widget.product['product_number']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Create Batch'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Consumer<CreateBatchViewmodel>(
          builder: (context, dataProvider, child) {
            return Provider.of<CreateBatchViewmodel>(context, listen: true)
                    .loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                    child: Column(
                      children: <Widget>[
                        _showLabel('Batch/day'),
                        CustomTextField(
                          controller: dataProvider.batchPerDayController,
                          hintText: 'e.g 200',
                          action: TextInputAction.search,
                          textInputType: TextInputType.number,
                          isFocus: false,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FittedBox(
                            child: DataTable(
                              dataRowHeight: 80,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    '#',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Material',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Quantity',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(label: Text('')),
                              ],
                              rows: _createBatchViewmodel!.rawMaterials
                                  .asMap()
                                  .entries
                                  .map<DataRow>((entry) {
                                final int index = entry.key + 1;
                                final Map<String, dynamic> item = entry.value;
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        '$index',
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        item['name'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        item['quantity'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    DataCell(
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ChooseStock(material: item),
                                            ),
                                          );
                                        },
                                        child: const Text(
                                          'Choose Stock',
                                          style: TextStyle(
                                            fontSize: 20,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: customButton(context, 'Add Batch', 52, double.infinity),
          ),
        ),
      ),
    );
  }
}

_showLabel(String txt) {
  return Container(
    alignment: Alignment.centerLeft,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        !txt.contains('/')
            ? Text(
                txt,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              )
            : Row(
                children: [
                  Text(
                    '${txt.split('/')[0]}/',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    txt.split('/')[1],
                    style: const TextStyle(
                        fontSize: 14, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
      ],
    ),
  );
}
