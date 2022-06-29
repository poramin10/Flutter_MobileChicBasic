// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_element, unused_local_variable, use_key_in_widget_constructors, unused_import, avoid_print, no_leading_underscores_for_local_identifiers, avoid_unnecessary_containers

import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/config/routes/router.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

import 'pages/homepage/homepage.dart';
import 'repositories/base/base_repository.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// ! Set Develop กรณี bad cercificate (กรณีการ Upload รูปภาพ)
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  // for develop mode only for bad cercificate
  if (kDebugMode) {
    HttpOverrides.global = new MyHttpOverrides();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<BaseState>(
          create: (context) => BaseState(),
        ),
      ],
      child: MyApp(),
    ),
  );
  Branch _b = Branch();
}

bool isInit = false;

class MyApp extends StatelessWidget {
  static const appTitle = 'Navigation Demo';
  final Routers _routers = Routers();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: appTitle,
        onGenerateRoute: _routers.generateRoute,
        initialRoute: '/datauser',
        builder: (BuildContext context, Widget? widget) {
          print('build >_<');
          BaseRepository(context);
          _initialErrorHandler(context);
          return widget!;
          // home: MyHomePage(title: appTitle),
        });
  }
}

_initialErrorHandler(BuildContext context) {
  // FlutterError.onError จะทำงานเมื่อมี Exception เกิดขึ้น
  // แต่ไม่มีการจับ(เช่น Try Catch)เอาไว้
  FlutterError.onError = (FlutterErrorDetails details) {
    print('onError catch some error');
    // showErrorMessage(context, '${details.summary}');
  };

  // ErrorWidget.builder จะทำงานเมื่อมี Error เกิดขึ้นตอน Build Widget ต่างๆ
  // (หน้าแดงตอน Debug หน้าขาวตอน Release) โดยจะแทนสิ่งที่เราประกาศไว้ไปแสดงแทน
  ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
    // showErrorMessage(context, '${errorDetails.summary}');
    return Center(
      child: Container(
        child: Text('${errorDetails.summary}'),
      ),
    );
  };
}
