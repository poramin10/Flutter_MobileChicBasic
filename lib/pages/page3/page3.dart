// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_mobile/shared_widgets/navigator_widget.dart';

class Page3 extends StatelessWidget {
  const Page3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page3')),
      body: Center(child: Text('Page 3')),
      drawer: Navigation(),
    );
  }
}