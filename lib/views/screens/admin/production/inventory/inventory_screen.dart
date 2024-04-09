import 'package:flutter/material.dart';
import 'package:industrial_watch/views/screens/admin/production/inventory/inventoryDetail_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../view-models/admin/production/inventory_viewmodel.dart';
import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_dialogbox.dart';

class InventoryScreen extends StatefulWidget {
  const InventoryScreen({super.key});

  @override
  State<InventoryScreen> createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
  InventoryViewModel? _inventoryViewModel;

  @override
  void initState() {
    _inventoryViewModel =
        Provider.of<InventoryViewModel>(context, listen: false);
    _inventoryViewModel?.getInventory(context);
    _inventoryViewModel!.getMaterials(context);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _inventoryViewModel!.getInventory(context);
    _inventoryViewModel!.getMaterials(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Inventory'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Provider.of<InventoryViewModel>(context, listen: true).loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: _inventoryViewModel!.inventoryList.isEmpty
                    ? const Center(
                        child: Text('No Data'),
                      )
                    : SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: FittedBox(
                          child: DataTable(
                            dataRowMaxHeight: 80,
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
                            rows: _inventoryViewModel!.inventoryList
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
                                      inventoryItem['raw_material_name'],
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  DataCell(
                                    Text(
                                      '${inventoryItem['total_quantity']} KG',
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
                                                InventoryDetailScreen(
                                                    material: inventoryItem),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        'Detail',
                                        style: TextStyle(
                                          fontSize: 20,
                                          decoration: TextDecoration.underline,
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
              ),
      ),
      bottomNavigationBar: SizedBox(
        height: 80,
        child: Center(
          child: GestureDetector(
            onTap: () {
              customDialogBox(
                context,
                _inventoryViewModel!.dialogData(context),
                () => _inventoryViewModel!.navigate(context),
                () {
                  _inventoryViewModel!.addStock(context);
                },
                'Add',
              );
            },
            child: customButton(context, 'Add Stock', 50, 211),
          ),
        ),
      ),
    );
  }
}
