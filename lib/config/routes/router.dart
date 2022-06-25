// ignore_for_file: unused_import, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_mobile/pages/api_listview/api_listview.dart';
import 'package:project_mobile/pages/createbranch/createbranch.dart';
import 'package:project_mobile/pages/createuser/createuser.dart';
import 'package:project_mobile/pages/datauser/datauser.dart';

import 'package:project_mobile/pages/homepage/homepage.dart';
import 'package:project_mobile/pages/page2/page2.dart';
import 'package:project_mobile/pages/page3/page3.dart';

///class จัดเก็บ route สำหรับการ route ด้วย pushName และอื่นๆที่ต้องใช้ name path
///
///สามารถจัดการ การ navigation ได้โดยภายในสามารถเขียนได้ว่าก่อนที่จะ navigate เราจะตรวจสอบอะไรบ้าง
class Routers {
  Route<dynamic>? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/homepage':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => MyHomePage(
            title: 'HomePage',
          ),
        );
      // ignore: no_duplicate_case_values
      case '/page2':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Page2(),
        );
      case '/page3':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => Page3(),
        );
      case '/apilistview':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => ApiListView(),
        );
      case '/datauser':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => DataUser(),
        );
      // ignore: no_duplicate_case_values
      case '/createbranch':
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => CreateBranch(),
        );
      // case '/createuser':
      //   return MaterialPageRoute(
      //     settings: settings,
      //     builder: (context) => CreateUser(),
      //   );
      case '/':
        // don't generate route on start-up
        return null;
      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Center(
              child: Text('No path for ${settings.name}'),
            ),
          ),
        );
    }
  }

  void dispose() {}
}
