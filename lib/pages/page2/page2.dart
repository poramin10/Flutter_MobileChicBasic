// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:project_mobile/shared_widgets/navigator_widget.dart';

class Page2 extends StatelessWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Page2')),
      body: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          Center(child: Text('ปรมินทร์เหลืองอมรศักดิ์')),
          Center(child: Text('ssssssssssssssssssssssssssssssssssssss')),
          Center(child: Text('ปรมินทร์ปรมินทร์ปรมินทร์ปรมินทร์ปรมินทร์ปรมินทร์')),
          Container(height:200 , width: 200, child: Center(child: Text('ผู้ใช๊'))),
          Center(child: Text('มิ้กกี้ ')),
          Center(child: Text('นุชิด นิดชู้')),
          Center(child: Text('สู้สู้ ')),
          Center(child: Text('ขั้นตอน')),
          Center(child: Text('ข้อมูลบัตรประชาชน')),
          Center(child: Text('ผู้ใหญ่')),
          Center(child: Text('กู้ใหญ่')),
          Center(child: Text("'กู้ใช้'")),
          Center(child: Text('เพิ่มผู้ใช้ สำเร็จแล้ว')),
          Container(
            height: 60,
            width: 200,
            child: Center(child: Text('อยากใช้'))),
        ],
      ),
      drawer: Navigation(),
    );
  }
}