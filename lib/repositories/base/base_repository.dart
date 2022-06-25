// ignore_for_file: unused_import, unnecessary_new

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/adapter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/environment/appsetting.dart';
import 'package:project_mobile/repositories/base/base_interceptor.dart';

class   BaseRepository {
  static Dio baseDio = new Dio();
  BaseRepository(BuildContext context) {
    var env = AppSetting.fromJson();
    baseDio = new Dio()
      ..options.baseUrl = env.apiConfig!.baseUrl!
      ..options.receiveTimeout = env.apiConfig!.receiveTimeout!
      ..options.connectTimeout = env.apiConfig!.connectTimeout!
      ..interceptors.add(CustomInterceptors(context));

    if (kDebugMode) {
      // //TODO: remove this function in production
      (baseDio.httpClientAdapter as DefaultHttpClientAdapter)
          .onHttpClientCreate = (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) {
          final isValidHost =
              ["192.168.1.149"].contains(host); // <-- allow only hosts in array
          return isValidHost;
        };
        return client;
      };
    }
  }
}
