import 'package:flutter/material.dart';
import 'package:industrial_watch/views/screens/admin/production/batch/batch_screen.dart';
import 'package:provider/provider.dart';
import '../../../../../view-models/admin/production/products_viewmodel.dart';
import '../../../../widgets/custom_Button.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductViewModel? _productsViewModel;

  @override
  void initState() {
    _productsViewModel = Provider.of<ProductViewModel>(context, listen: false);
    _productsViewModel!.getProducts(context);
    super.initState();
  }

  Future<void> _refreshRawMaterials(BuildContext context) async {
    _productsViewModel!.getProducts(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: const Text('Products'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshRawMaterials(context),
        child: Consumer<ProductViewModel>(
          builder: (context, dataProvider, child) {
            return Provider.of<ProductViewModel>(context, listen: true).loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Provider.of<ProductViewModel>(context, listen: true)
                        .linkedProducts
                        .isEmpty
                    ? const Center(
                        child: Text('No Batch Found'),
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
                            Expanded(
                              child: ListView.builder(
                                itemCount: dataProvider.linkedProducts.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    children: [
                                      ListTile(
                                        title: Text(
                                            dataProvider.linkedProducts[index]
                                                ['name'],
                                            overflow: TextOverflow.visible,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            )),
                                        trailing: const Icon(
                                            Icons.arrow_forward_ios_rounded),
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => BatchScreen(
                                                product: dataProvider
                                                    .linkedProducts[index],
                                                index: index,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      (index !=
                                              dataProvider
                                                      .linkedProducts.length -
                                                  1)
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
              Navigator.of(context).pushNamed('/linkProduct').whenComplete(
                    () => _productsViewModel!.getProducts(context),
                  );
            },
            child: customButton(context, 'Link Product', 52, double.infinity),
          ),
        ),
      ),
    );
  }
}
