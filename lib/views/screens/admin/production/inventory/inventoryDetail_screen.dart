import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../view-models/admin/production/inventoryDetail_viewmodel.dart';
import '../../../../../view-models/admin/production/inventory_viewmodel.dart';
import '../../../../widgets/custom_Button.dart';

class InventoryDetailScreen extends StatefulWidget {
  Map<String, dynamic> material;

  InventoryDetailScreen({super.key, required this.material});

  @override
  State<InventoryDetailScreen> createState() => _InventoryDetailScreenState();
}

class _InventoryDetailScreenState extends State<InventoryDetailScreen> {
  InventoryDetailViewModel? _inventoryDetailViewmodel;
  InventoryViewModel? _inventoryViewmodel;

  @override
  void initState() {
    _inventoryDetailViewmodel =
        Provider.of<InventoryDetailViewModel>(context, listen: false);
    _inventoryViewmodel =
        Provider.of<InventoryViewModel>(context, listen: false);
    _inventoryDetailViewmodel?.getInventoryDetails(
        context, widget.material['raw_material_id']);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _inventoryDetailViewmodel!
        .getInventoryDetails(context, widget.material['raw_material_id']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(widget.material['raw_material_name']),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Provider.of<InventoryDetailViewModel>(context, listen: true)
                .loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: _inventoryDetailViewmodel!.inventoryDetailsList.isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: FittedBox(
                          child: DataTable(
                            dataRowHeight: 60,
                            columns: const [
                              DataColumn(
                                label: Text(
                                  '#',
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
                            ],
                            rows: _inventoryDetailViewmodel!
                                .inventoryDetailsList
                                .asMap()
                                .entries
                                .map<DataRow>((entry) {
                              final int index = entry.key + 1;
                              final Map<String, dynamic> inventoryItem =
                                  entry.value;
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
                                      '${inventoryItem['price_per_unit'].split('.')[0]}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '${inventoryItem['quantity']} KG',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '${inventoryItem['purchased_date']}',
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
