import 'package:flutter/material.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_dialogbox.dart';
import '../../../views/widgets/custom_snackbar.dart';
import '../../../views/widgets/custom_textfield.dart';

class LinkProductViewModel extends ChangeNotifier {
  TextEditingController packsController = TextEditingController();
  TextEditingController pieceController = TextEditingController();
  TextEditingController toleranceController = TextEditingController();

  bool _loading = true;
  get loading => _loading;

  setLoading(bool value) {
    _loading = value;
  }

  List<dynamic> products = [];
  Map<String, dynamic> selectedProduct = {};

  Future<void> getProducts(BuildContext context) async {
    products.clear();
    setLoading(true);
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetUnlinkedProducts',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        products.addAll(data);
        products = products.toSet().toList();
        setLoading(false);
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }

  addProduct(context) async {
    Map<String, dynamic> newProduct = {};

    if (selectedProduct.isNotEmpty ||
        pieceController.text.isNotEmpty ||
        packsController.text.isNotEmpty ||
        toleranceController.text.isNotEmpty) {
      newProduct = {
        "product_number": selectedProduct['product_number'],
        "packs_per_batch": packsController.text,
        "piece_per_pack": pieceController.text,
        "rejection_tolerance": toleranceController.text
      };

      print(newProduct);

      await ApiRepo().apiFetch(
        context: context,
        path: 'Production/LinkProduct',
        body: newProduct,
        requestMethod: RequestMethod.POST,
        beforeSend: () {
          print('Processing Data');
        },
        onSuccess: (data) {
          print('Data Processed');
          print(data);
          customSnackBar(context, data['message']);
          selectedProduct.clear();
          pieceController.clear();
          packsController.clear();
          toleranceController.clear();
          Navigator.pop(context);
        },
        onError: (error) {
          print(error.toString());
          customSnackBar(context, error.toString());
        },
      );
    } else {
      customSnackBar(context, "Please fill all fields");
    }
  }

  dropDownOnChanged(Map<String, dynamic> v) {
    selectedProduct = v;
    notifyListeners();
  }
}
