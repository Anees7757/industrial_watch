import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../view-models/admin/production/rawMaterials_viewmodel.dart';
import '../../../widgets/custom_Button.dart';
import '../../../widgets/custom_dialogbox.dart';
import '../../../widgets/custom_textfield.dart';

class RawMaterialScreen extends StatefulWidget {
  const RawMaterialScreen({super.key});

  @override
  State<RawMaterialScreen> createState() => _RawMaterialScreenState();
}

class _RawMaterialScreenState extends State<RawMaterialScreen> {
  RawMaterialsViewModel? _rawMaterialsViewModel;

  @override
  void initState() {
    _rawMaterialsViewModel =
        Provider.of<RawMaterialsViewModel>(context, listen: false);
    _rawMaterialsViewModel?.getMaterials(context);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _rawMaterialsViewModel!.getMaterials(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Raw Materials'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Provider.of<RawMaterialsViewModel>(context, listen: true).loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: _rawMaterialsViewModel!.rawMaterials.isEmpty
                    ? const Center(
                        child: Text('No Rule'),
                      )
                    : ListView.builder(
                        itemCount: _rawMaterialsViewModel!.rawMaterials.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color(0xFFDDDDDD).withOpacity(0.5),
                            ),
                            child: ListTile(
                              title: Text(
                                  _rawMaterialsViewModel!.rawMaterials[index]
                                      ['name'],
                                  overflow: TextOverflow.visible,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                  )),
                              // trailing: IconButton(
                              //   splashRadius: 20,
                              //   onPressed: () {
                              //     _rawMaterialsViewModel!
                              //             .materialController.text =
                              //         _rawMaterialsViewModel!
                              //             .rawMaterials[index]['name'];
                              //     customDialogBox(
                              //       context,
                              //       Column(children: [
                              //         const Row(
                              //           children: [
                              //             Text('Edit Raw Material',
                              //                 overflow: TextOverflow.visible,
                              //                 textAlign: TextAlign.left,
                              //                 style: TextStyle(
                              //                   fontSize: 18,
                              //                   fontWeight: FontWeight.w600,
                              //                 )),
                              //           ],
                              //         ),
                              //         const SizedBox(height: 20),
                              //         CustomTextField(
                              //           controller: _rawMaterialsViewModel!
                              //               .materialController,
                              //           hintText: 'e.g iron',
                              //           action: TextInputAction.done,
                              //           textInputType: TextInputType.text,
                              //           isFocus: true,
                              //         ),
                              //         const SizedBox(height: 25),
                              //       ]),
                              //       () => _rawMaterialsViewModel!
                              //           .navigate(context),
                              //       () {
                              //         _rawMaterialsViewModel!.editRule(
                              //             context,
                              //             _rawMaterialsViewModel!
                              //                 .rawMaterials[index]['id']);
                              //         //     .then((_) {
                              //         //   _refreshRawMaterials(context);
                              //         // });
                              //       },
                              //       'Edit',
                              //     );
                              //     // _rawMaterialsViewModel!
                              //     //     .delete(context, index);
                              //   },
                              //   icon: const Icon(Icons.edit,
                              //       color: Color(0xFF49454F)),
                              // ),
                            ),
                          );
                        },
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
                Column(children: [
                  const Row(
                    children: [
                      Text('Add Raw Material',
                          overflow: TextOverflow.visible,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          )),
                    ],
                  ),
                  const SizedBox(height: 20),
                  CustomTextField(
                    controller: _rawMaterialsViewModel!.materialController,
                    hintText: 'e.g Iron',
                    action: TextInputAction.done,
                    textInputType: TextInputType.text,
                    isFocus: true,
                  ),
                  const SizedBox(height: 25),
                ]),
                () => _rawMaterialsViewModel!.navigate(context),
                () {
                  _rawMaterialsViewModel!.addRule(context);
                },
                'Add',
              );
            },
            child: customButton(context, 'Add Material', 50, 211),
          ),
        ),
      ),
    );
  }
}
