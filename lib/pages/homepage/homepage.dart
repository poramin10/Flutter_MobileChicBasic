// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_mobile/shared_widgets/navigator_widget.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Text('Homepage'),
      ),
      drawer: Navigation(),
    );
  }
}