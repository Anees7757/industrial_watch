import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:industrial_watch/utils/error_screen.dart';

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
    required BuildContext context,
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
      method: getHttpMethod(requestMethod!),
    );

    Dio().fetch(options).then((value) {
      if (onSuccess != null && value.statusCode == 200) {
        onSuccess(value.data);
      } else if (onSuccess != null && value.statusCode == 201) {
        print('Data Added Successfully');
      } else {
        onError!(value.data);
        //showErrorScreen(context, value.statusCode!, value.statusMessage!);
      }
    }).onError((error, stackTrace) {
      onError!(error);
    });
  }
}

String getHttpMethod(RequestMethod requestMethod) {
  switch (requestMethod) {
    case RequestMethod.GET:
      return 'GET';
    case RequestMethod.POST:
      return 'POST';
    case RequestMethod.PUT:
      return 'PUT';
    case RequestMethod.DELETE:
      return 'DELETE';
    default:
      return 'GET';
  }
}
