// ignore_for_file: void_checks, deprecated_member_use, empty_catches, unused_element, unnecessary_overrides

import 'package:dio/dio.dart';

class DioInterceptors extends InterceptorsWrapper {
  // ignore: unused_field
  final Dio _dio;
  DioInterceptors(this._dio);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    options.path = options.path.toLowerCase();
    options = _addToken(options);
    return super.onRequest(options, handler);
  }

  _addToken(RequestOptions options) {
    // options.headers.addAll({'Authorization': CommonMethods.getTokenString});
    return options;
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

  @override
  // ignore: avoid_renaming_method_parameters
  Future onError(DioError dioError, ErrorInterceptorHandler handler) async {
    return super.onError(dioError, handler);
  }
}
