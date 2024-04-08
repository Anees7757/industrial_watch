import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../widgets/custom_gridview.dart';

class ProductionScreen extends StatefulWidget {
  const ProductionScreen({super.key});

  @override
  State<ProductionScreen> createState() => _ProductionScreenState();
}

class _ProductionScreenState extends State<ProductionScreen> {
  final List<String> titles = [
    'Raw Materials',
    'Add Product',
    'Inventory',
    'Products'
  ];

  final List<String> icons = [
    'assets/icons/raw_materials.png',
    'assets/icons/add_product.png',
    'assets/icons/inventory.png',
    'assets/icons/products.png'
  ];

  final List<String> navigationVal = [
    'raw_materials',
    'add_product',
    'inventory',
    'products'
  ];

  @override
  Widget build(BuildContext context) {
    final Widget svg = SvgPicture.asset(
      'assets/images/dashboard_box.svg',
      alignment: Alignment.topCenter,
    );

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light),
    );
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text('Production'),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          svg,
          Container(
            margin: const EdgeInsets.only(top: 130),
            padding: const EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F7F7),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Column(
              children: [
                CustomGridView(
                  titles: titles,
                  navigationVal: navigationVal,
                  icons: icons,
                  dashboard: 'production',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
