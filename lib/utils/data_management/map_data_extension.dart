// ignore_for_file: unused_import

import 'package:project_mobile/main.dart';
import 'package:project_mobile/main.reflectable.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/models/result.dart';
import 'package:project_mobile/shared_widgets/error_message.dart';
import 'package:project_mobile/utils/data_management/reflector.dart';
import 'package:dio/dio.dart';
import 'package:reflectable/reflectable.dart';

extension MapData on Future<Response> {
  Future<Result<List<T>?>>? getList<T>() async {
    initializeReflectable();
    var response = await this;
    Result<List<T>?> result = Result<List<T>?>(
      response.data['success'],
      response.data['message'],
      response.data['traceId'],
      null,
    );
    try {
      if (response.data['success']) {
        List data = response.data['data'] as List;
        var atype = reflector.reflectType(T) as ClassMirror;

        var resultData = data
            .map<T>((e) => atype.newInstance('fromJson', [e]) as T)
            .toList();
        result.data = resultData;
      } else {
        if (response.statusCode == 401) {
          // TODO: handling unauthorization exception
        } else {
          showErrorMessage(
              navigatorKey.currentContext!, result.message ?? 'error');
        }
      }
    } on Exception catch (e) {
      result.success = false;
      result.message = e.toString();
      showErrorMessage(navigatorKey.currentContext!, result.message ?? 'error');
    }
    return result;
  }

  Future<Result<T?>> getSingle<T>() async {
    initializeReflectable();
    var response = await this;
    Result<T?>? result;
    try {
      result = Result<T?>(response.data['success'], response.data['message'],
          response.data['traceId'], null);
      if (response.data['success']) {
        var atype = reflector.reflectType(T) as ClassMirror;
        //Account acc = Account.fromJson(json)
        var resultData =
            atype.newInstance('fromJson', [response.data['data']]) as T;
        result.data = resultData;
      } else {
        if (response.statusCode == 401) {
          // TODO: handling unauthorization exception
        } else {
          showErrorMessage(
              navigatorKey.currentContext!, result.message ?? 'error');
        }
      }
    } catch (e) {
      result = Result(false, response.statusMessage, '', null);
      showErrorMessage(navigatorKey.currentContext!, result.message ?? 'error');
    }
    return result;
  }

  Future<Result<dynamic>> asResult() async {
    var response = await this;
    Result<dynamic> result;
    try {
      result = Result<dynamic>(
        response.data['success'],
        response.data['message'],
        response.data['traceId'],
        response.data['data'],
      );
      if (!(response.data['success'] ?? false)) {
        showErrorMessage(
            navigatorKey.currentContext!, result.message ?? 'error');
      }
    } catch (e) {
      result = Result(false, response.statusMessage, '', null);
        showErrorMessage(
              navigatorKey.currentContext!, result.message ?? 'error');
    }
    return result;
  }
}
