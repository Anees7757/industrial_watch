// import 'package:flutter/material.dart';
// import 'package:industrial_watch/views/screens/admin/production/batch/products_screen.dart';
//
// import '../../../../widgets/custom_Button.dart';
// import '../../../../widgets/custom_appbar.dart';
// import '../../../../widgets/custom_productCom.dart';
// import '../defects/defects_screen.dart';
//
// class BatchDetailScreen extends StatefulWidget {
//   String? batchNo;
//
//   BatchDetailScreen({super.key, required this.batchNo});
//
//   @override
//   State<BatchDetailScreen> createState() => _BatchDetailScreenState();
// }
//
// class _BatchDetailScreenState extends State<BatchDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: customAppBar(context, widget.batchNo!),
//       body: Container(
//         margin: const EdgeInsets.fromLTRB(40, 30, 40, 0),
//         child: Column(
//           children: [
//             customProductCom('Product Name', 'Disc'),
//             const SizedBox(height: 15),
//             customProductCom('Expected Yield', '98%'),
//             const SizedBox(height: 15),
//             customProductCom('Output Yield', '70%'),
//             const SizedBox(height: 50),
//             const Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text('Formula',
//                     style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     )),
//                 SizedBox(width: 5),
//                 Text('per item',
//                     style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 16,
//                         fontStyle: FontStyle.italic)),
//               ],
//             ),
//             DataTable(
//               columns: const [
//                 DataColumn(
//                   label: Text('#'),
//                 ),
//                 DataColumn(
//                   label: Text('Material'),
//                 ),
//                 DataColumn(
//                   label: Text('Quantity'),
//                 ),
//               ],
//               rows: const [
//                 DataRow(cells: [
//                   DataCell(Text('1')),
//                   DataCell(Text('Iron')),
//                   DataCell(Text('500 G')),
//                 ]),
//                 DataRow(cells: [
//                   DataCell(Text('2')),
//                   DataCell(Text('Copper')),
//                   DataCell(Text('90 G')),
//                 ])
//               ],
//             ),
//           ],
//         ),
//       ),
//       bottomNavigationBar: Container(
//         height: 80,
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: Center(
//           child: GestureDetector(
//             onTap: () {
//               Navigator.of(context).push(
//                 MaterialPageRoute(
//                   builder: (context) => ProductsScreen(
//                     batchNo: widget.batchNo!,
//                   ),
//                 ),
//               );
//             },
//             child: customButton(context, 'Defects', 52, double.infinity),
//           ),
//         ),
//       ),
//     );
//   }
// }
