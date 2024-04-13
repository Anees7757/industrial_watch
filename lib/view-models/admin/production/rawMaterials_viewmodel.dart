import 'package:flutter/material.dart';
import '../../../repositories/api_repo.dart';
import '../../../utils/request_methods.dart';
import '../../../views/widgets/custom_snackbar.dart';

class RawMaterialsViewModel extends ChangeNotifier {
  List<dynamic> rawMaterials = [];
  TextEditingController materialController = TextEditingController();
  bool loading = true;

  Future<void> getMaterials(BuildContext context) async {
    loading = true;
    await ApiRepo().apiFetch(
      context: context,
      path: 'Production/GetAllRawMaterials',
      requestMethod: RequestMethod.GET,
      beforeSend: () {
        print('Processing Data');
      },
      onSuccess: (data) {
        print('Data Processed');
        rawMaterials = data;
        rawMaterials = rawMaterials.toSet().toList();
        loading = false;
        notifyListeners();
      },
      onError: (error) {
        print(error.toString());
        loading = false;
        //customSnackBar(context, error.toString());
        notifyListeners();
      },
    );
  }

  addRule(BuildContext context) async {
    if (materialController.text.isNotEmpty) {
      if (!rawMaterials.contains(materialController.text)) {
        await ApiRepo().apiFetch(
          context: context,
          path: 'Production/AddRawMaterial?name=${materialController.text}',
          requestMethod: RequestMethod.POST,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) async {
            print(data['message']);
            customSnackBar(context, data['message']);
            await getMaterials(context);
            notifyListeners();
          },
          onError: (error) {
            print(error.toString());
            //customSnackBar(context, error.toString());
            notifyListeners();
          },
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        materialController.clear();
      } else {
        customSnackBar(context, 'Raw Material Already exists');
      }
    }
  }

  editRule(BuildContext context, int rawMaterialID) async {
    if (materialController.text.isNotEmpty) {
      if (!rawMaterials.contains(materialController.text)) {
        Map<String, dynamic> data = {
          "id": rawMaterialID,
          "name": materialController.text,
        };

        print(data);

        await ApiRepo().apiFetch(
          context: context,
          path: 'Production/UpdateRawMaterial',
          body: data,
          requestMethod: RequestMethod.PUT,
          beforeSend: () {
            print('Processing Data');
          },
          onSuccess: (data) async {
            print(data['message']);
            customSnackBar(context, data['message']);
            rawMaterials.clear();
            getMaterials(context);
            notifyListeners();
          },
          onError: (error) {
            print(error.toString());
            //customSnackBar(context, error.toString());
            notifyListeners();
          },
        );
        if (!context.mounted) return;
        Navigator.of(context).pop();
        materialController.clear();
      } else {
        customSnackBar(context, 'Raw Material Already exists');
      }
    }
    notifyListeners();
  }

  navigate(BuildContext context) {
    Navigator.pop(context);
    materialController.clear();
    notifyListeners();
  }

// Future<void> delete(BuildContext context, int index) async {
//   await ApiRepo().apiFetch(
//     context: context,
//     path: 'Rule/delete_rule?id=${rawMaterials[index]['id']}',
//     requestMethod: RequestMethod.DELETE,
//     beforeSend: () {
//       print('Processing Data');
//     },
//     onSuccess: (data) {
//       print(data['message']);
//       rawMaterials.removeAt(index);
//       customSnackBar(context, data['message']);
//       notifyListeners();
//     },
//     onError: (error) {
//       print(error.toString());
//       //customSnackBar(context, error.toString());
//       notifyListeners();
//     },
//   );
// }
}
