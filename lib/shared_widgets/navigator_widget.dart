// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

class Navigation extends StatelessWidget {
  const Navigation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BaseState>(builder: (context, baseState, child) {
      return Drawer(
        // ! Tab Navigation
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              // ignore: sort_child_properties_last
              child: Text(
                'Header Navigation',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.blue),
            ),
            ListTile(
              // tileColor: Colors.blue,
              title: Text('HomePage'),
              onTap: () {
                if (baseState.drawerActivePage != 1) {
                  baseState.drawerActivePage = 1;
                  Navigator.pop(context); //! ปิด Navigation ลง
                  Navigator.of(context).pushReplacementNamed('/homepage');
                }
              },
            ),
            ListTile(
              title: Text('CreateBranch'),
              onTap: () {
                if (baseState.drawerActivePage != 2) {
                  baseState.drawerActivePage = 2;
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/createbranch');
                }
              },
            ),
            // ListTile(
            //   title: Text('CreateUser'),
            //   onTap: () {
            //     if (baseState.drawerActivePage != 3) {
            //       baseState.drawerActivePage = 3;
            //       Navigator.pop(context);
            //       Navigator.of(context).pushReplacementNamed('/createuser');
            //     }
            //   },
            // ),
            ListTile(
              title: Text('API ListView Branch'),
              onTap: () {
                if (baseState.drawerActivePage != 4) {
                  baseState.drawerActivePage = 4;
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/apilistview');
                }
              },
            ),
            ListTile(
              title: Text('API User'),
              onTap: () {
                if (baseState.drawerActivePage != 5) {
                  baseState.drawerActivePage = 5;
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/datauser');
                }
              },
            ),
            ListTile(
              title: Text('Page2'),
              onTap: () {
                if (baseState.drawerActivePage != 5) {
                  baseState.drawerActivePage = 5;
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/page2');
                }
              },
            )
          ],
        ),
      );
    });
  }
}
