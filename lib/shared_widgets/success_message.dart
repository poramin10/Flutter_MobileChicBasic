// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:flutter/material.dart';

void showSuccessMessage(BuildContext context, String content) {
  return WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color.fromARGB(255, 0, 119, 18),
        content: Text(
          '$content',
          maxLines: 2,
          style: TextStyle(color:Colors.white , fontWeight: FontWeight.bold),
        ),
        duration: Duration(milliseconds: 2000),
      ),
    );
  });
}


