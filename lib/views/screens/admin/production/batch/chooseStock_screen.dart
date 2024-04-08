import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../view-models/admin/production/chooseStock_viewmodel.dart';
import '../../../../widgets/custom_Button.dart';

class ChooseStock extends StatefulWidget {
  Map<String, dynamic> material;

  ChooseStock({super.key, required this.material});

  @override
  State<ChooseStock> createState() => _ChooseStockState();
}

class _ChooseStockState extends State<ChooseStock> {
  ChooseStockViewmodel? _chooseStockViewmodel;

  @override
  void initState() {
    _chooseStockViewmodel =
        Provider.of<ChooseStockViewmodel>(context, listen: false);
    _chooseStockViewmodel!
        .getStock(context, widget.material['raw_material_id']);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _chooseStockViewmodel!
        .getStock(context, widget.material['raw_material_id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Choose stock for ${widget.material['name']}'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Consumer<ChooseStockViewmodel>(
          builder: (context, dataProvider, child) {
            return Provider.of<ChooseStockViewmodel>(context, listen: true)
                    .loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: <Widget>[
                        SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: FittedBox(
                            child: DataTable(
                              dataRowHeight: 80,
                              columnSpacing: 20,
                              columns: const [
                                DataColumn(
                                  label: Text(
                                    'Stock#',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Quantity',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Price/kg',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(
                                  label: Text(
                                    'Date',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                DataColumn(label: Text('')),
                              ],
                              rows: _chooseStockViewmodel!.stock
                                  .asMap()
                                  .entries
                                  .map<DataRow>((entry) {
                                final int index = entry.key;
                                final Map<String, dynamic> item = entry.value;
                                return DataRow(
                                  cells: [
                                    DataCell(
                                      Text(
                                        item['stock_number'],
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '${item['quantity']}',
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        '${item['price_per_kg']}',
                                      ),
                                    ),
                                    DataCell(
                                      Text(
                                        item['purchased_date'],
                                      ),
                                    ),
                                    DataCell(
                                      Transform.scale(
                                        scale: 1.3,
                                        child: Checkbox(
                                          value: dataProvider
                                              .stockSelections[index],
                                          onChanged: (bool? value) {
                                            dataProvider.checkBoxOnChanged(
                                                value!, index);
                                          },
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
            onTap: () {
              _chooseStockViewmodel!
                  .addBatch(context, widget.material['raw_material_id']);
            },
            child: customButton(context, 'Done', 52, double.infinity),
          ),
        ),
      ),
    );
  }
}
