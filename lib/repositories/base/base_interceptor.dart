// ignore_for_file: unused_import

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

class CustomInterceptors extends Interceptor {
  BuildContext context;
  CustomInterceptors(this.context);

  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    //TODO: Get Bearer token in this onRequest().

    var provider = Provider.of<BaseState>(context, listen: false);
    options.headers = {
      "Content-type": "application/json; charset=utf-8 ",
      "Authorization": ""
    };
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (!(response.data['success'] ?? false)) {
      // showErrorMessage(context, response.data['message']);
      // showErrorMessage(context, 'ref number : ${response.data['traceId']}');
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    Response? response;
    var message = 'พบข้อผิดพลาดจาก interceptor';
    if ((err.response?.statusMessage) != null) {
      message = 'พบข้อผิดพลาดจากระบบหลังบ้าน \n';
      message += err.response!.statusMessage!;
    } else if (err.error != null) {
      message = 'พบข้อผิดพลาดจากแอปพลิเคชัน \n';
      message += err.error.toString();
    }

    response = Response(
        statusCode: err.response?.statusCode ?? 500,
        requestOptions: err.requestOptions,
        data: {
          'success': false,
          'message': message,
        });
    if (response.statusCode == 401) {
      //TODO: Do Something for unauthrization .
    }
    // showErrorMessage(context, err.message);
    return handler.resolve(response);
  }
}
