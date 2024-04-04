import 'package:flutter/material.dart';
import 'package:industrial_watch/view-models/admin/production/batch_viewmodel.dart';
import 'package:provider/provider.dart';
import '../../../../widgets/custom_Button.dart';
import '../../../../widgets/custom_appbar.dart';

class BatchScreen extends StatefulWidget {
  const BatchScreen({super.key});

  @override
  State<BatchScreen> createState() => _BatchScreenState();
}

class _BatchScreenState extends State<BatchScreen> {
  BatchViewModel? _batchViewModel;

  @override
  void initState() {
    _batchViewModel = Provider.of<BatchViewModel>(context, listen: false);
    _batchViewModel!.getBatches(context);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _batchViewModel!.getBatches(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Batch'),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Consumer<BatchViewModel>(
          builder: (context, dataProvider, child) {
            return Provider.of<BatchViewModel>(context, listen: true).loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                    child: Column(
                      children: [
                        // CustomTextField(
                        //   controller: dataProvider.searchController,
                        //   hintText: 'Search',
                        //   action: TextInputAction.search,
                        //   textInputType: TextInputType.number,
                        //   isFocus: false,
                        // ),
                        // const SizedBox(height: 10),
                        dataProvider.batches.isEmpty
                            ? const Center(
                                child: Text('No Batch'),
                              )
                            : Expanded(
                                child: ListView.builder(
                                  itemCount: dataProvider.batches.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
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
                                          onTap: () {},
                                        ),
                                        (index !=
                                                dataProvider.batches.length - 1)
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
      ),
      bottomNavigationBar: Container(
        height: 80,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .pushNamed('/createBatch')
                  .whenComplete(() => setState(() {}));
            },
            child:
                customButton(context, 'Create Batch', 56.79, double.infinity),
          ),
        ),
      ),
    );
  }
}
