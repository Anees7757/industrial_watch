// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// import '../../../../view-models/admin/production/production_viewmodel.dart';
// import '../../../widgets/custom_Button.dart';
// import '../../../widgets/custom_appbar.dart';
// import '../../../widgets/custom_textfield.dart';
// import 'batch/createBatch_screen.dart';
//
// class ProductionScreen extends StatefulWidget {
//   const ProductionScreen({super.key});
//
//   @override
//   State<ProductionScreen> createState() => _ProductionScreenState();
// }
//
// class _ProductionScreenState extends State<ProductionScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: customAppBar(context, 'Production'),
//       body: Consumer<ProductionViewModel>(
//         builder: (context, dataProvider, child) {
//           return Container(
//             margin: const EdgeInsets.fromLTRB(15, 10, 15, 0),
//             child: Column(
//               children: [
//                 CustomTextField(
//                   controller: dataProvider.searchController,
//                   hintText: 'Search',
//                   action: TextInputAction.search,
//                   textInputType: TextInputType.number,
//                   isFocus: false,
//                 ),
//                 const SizedBox(height: 10),
//                 dataProvider.batches.isEmpty
//                     ? const Center(
//                         child: Text('No Batch'),
//                       )
//                     : (dataProvider.searchController.text.isNotEmpty)
//                         ? (dataProvider.filteredBatches.isEmpty)
//                             ? const Center(
//                                 child: Text('No Batch Found'),
//                               )
//                             : Expanded(
//                                 child: ListView.builder(
//                                   itemCount:
//                                       dataProvider.filteredBatches.length,
//                                   itemBuilder:
//                                       (BuildContext context, int index) {
//                                     return Column(
//                                       children: [
//                                         ListTile(
//                                           title: Text(
//                                               dataProvider.filteredBatches.keys
//                                                   .elementAt(index),
//                                               overflow: TextOverflow.visible,
//                                               style: const TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                               )),
//                                           trailing: const Icon(
//                                               Icons.arrow_forward_ios_rounded),
//                                           onTap: () {
//                                             dataProvider.navigate(
//                                                 context,
//                                                 dataProvider
//                                                     .filteredBatches.keys
//                                                     .elementAt(index));
//                                           },
//                                         ),
//                                         (index !=
//                                                 dataProvider.filteredBatches
//                                                         .length -
//                                                     1)
//                                             ? const Divider(
//                                                 height: 5,
//                                                 thickness: 1,
//                                                 color: Color(0xFFBFBFBF),
//                                               )
//                                             : const SizedBox(),
//                                       ],
//                                     );
//                                   },
//                                 ),
//                               )
//                         : Expanded(
//                             child: ListView.builder(
//                               itemCount: dataProvider.batches.length,
//                               itemBuilder: (BuildContext context, int index) {
//                                 return Column(
//                                   children: [
//                                     ListTile(
//                                       title: Text(
//                                           dataProvider.batches.keys
//                                               .elementAt(index),
//                                           overflow: TextOverflow.visible,
//                                           style: const TextStyle(
//                                             fontWeight: FontWeight.w500,
//                                           )),
//                                       trailing: const Icon(
//                                           Icons.arrow_forward_ios_rounded),
//                                       onTap: () {
//                                         dataProvider.navigate(
//                                             context,
//                                             dataProvider.batches.keys
//                                                 .elementAt(index));
//                                       },
//                                     ),
//                                     (index != dataProvider.batches.length - 1)
//                                         ? const Divider(
//                                             height: 5,
//                                             thickness: 1,
//                                             color: Color(0xFFBFBFBF),
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//               ],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: Container(
//         height: 80,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context)
//                   .pushNamed('/createBatch')
//                   .whenComplete(() => setState(() {}));
//             },
//             child:
//                 customButton(context, 'Create Batch', 56.79, double.infinity),
//           ),
//         ),
//       ),
//     );
//   }
// }
