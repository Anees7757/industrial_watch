// import 'package:api_test_1/Constants/api_constants.dart';
// import 'package:api_test_1/Remote/Api%20Client/api_client.dart';

// class ApiRepo {
//   apiFetch({
//     required String? path,
//     Function()? beforeSend,
//     Function(dynamic data)? onSuccess,
//     Function(dynamic error)? onError,
//   }) {
//     ApiClient(baseUrl: ApiConstants.instance.baseurl, path: path!).apiRequest(
//       beforeSend: beforeSend ?? beforeSend,
//       onSuccess: (data) {
//         if (onSuccess != null) {
//           onSuccess((data).isEmpty ? List.empty() : data);
//           /*data.map((e) => User.fromJson(e)).toList()*/
//         }
//       },
//       onError: onError ?? onError,
//     );
//   }
// }
