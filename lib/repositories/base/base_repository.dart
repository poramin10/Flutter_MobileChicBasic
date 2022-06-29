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
  }
}
