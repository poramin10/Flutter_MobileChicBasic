// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, prefer_const_constructors, avoid_print, use_build_context_synchronously

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/repositories/branch_repository.dart';
import 'package:project_mobile/shared_widgets/error_message.dart';
import 'package:project_mobile/shared_widgets/navigator_widget.dart';
import 'package:project_mobile/shared_widgets/success_message.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

class CreateBranch extends StatefulWidget {
  CreateBranch({Key? key}) : super(key: key);

  @override
  State<CreateBranch> createState() => _CreateBranchState();
}

class _CreateBranchState extends State<CreateBranch> {
  final _formKey = GlobalKey<FormState>();
  final _valueBranch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Branch')),
      // ignore: prefer_const_literals_to_create_immutables
      body: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Center(
              child: Text(
                'เพิ่มสาขา',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        controller: _valueBranch,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'กรุณากรอกชื่อสาขา';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          hintText: 'กรุณากรอกชื่อสาขา',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await createBranch(_valueBranch.text);
                              _valueBranch.clear();
                            }

                          },
                          child: Text('เพิ่มข้อมูล')),

                      // Text(baseState.successmessage.toString()),
                    ],
                  )),
            )
          ]),

      drawer: Navigation(),
    );
  }

  Future<void> createBranch(String branchName) async {
     if (branchName.isNotEmpty) {
      BranchRepository branchRepository = BranchRepository();
      var isSuccess =
          await branchRepository.postBranch(Branch(namebranch: branchName));
      if (isSuccess) {
        showSuccessMessage(context, 'เพิ่มสำเร็จ');
      } else {
        showErrorMessage(context, 'เพิ่มไม่สำเร็จ');
      }
    }
  }
}
