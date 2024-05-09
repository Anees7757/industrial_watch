import 'package:flutter/cupertino.dart';

import '../constants/api_constants.dart';
import '../services/remote/api_client.dart';
import '../utils/request_methods.dart';

class ApiRepo {
  apiFetch({
    required String? path,
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
    RequestMethod? requestMethod,
    required BuildContext context,
    dynamic body,
  }) {
    ApiClient(
            baseUrl: ApiConstants.instance.baseurl,
            path: path!,
            body: body,
            requestMethod: requestMethod)
        .apiRequest(
      context: context,
      beforeSend: beforeSend ?? beforeSend,
      onSuccess: (data) {
        if (onSuccess != null) {
          onSuccess((data).isEmpty ? List.empty() : data);
          /*data.map((e) => User.fromJson(e)).toList()*/
        }
      },
      onError: onError ?? onError,
    );
  }
}
