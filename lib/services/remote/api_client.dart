import 'dart:convert';

import 'package:dio/dio.dart';

import '../../utils/request_methods.dart';

class ApiClient {
  String baseUrl;
  String path;
  Map<String, dynamic>? headers;
  Map<String, dynamic>? queryParameters;
  Map<String, dynamic>? body;
  RequestMethod? requestMethod;

  ApiClient({
    required this.baseUrl,
    required this.path,
    this.body,
    this.headers,
    this.queryParameters,
    this.requestMethod,
  });

  apiRequest({
    Function()? beforeSend,
    Function(dynamic data)? onSuccess,
    Function(dynamic error)? onError,
  }) {
    if (beforeSend != null) {
      beforeSend();
    }
    final options = RequestOptions(
      baseUrl: baseUrl,
      path: path,
      data: jsonEncode(body),
      headers: headers,
      queryParameters: queryParameters,
      method: requestMethod == RequestMethod.GET ? 'GET' : 'POST',
    );

    Dio().fetch(options).then((value) {
      if (onSuccess != null && value.statusCode == 200) {
        onSuccess(value.data);
      } else if (onSuccess != null && value.statusCode == 201) {
        print('Data Added Successfully');
      }
    }).onError((error, stackTrace) {
      onError!(error);
    });
  }
}
