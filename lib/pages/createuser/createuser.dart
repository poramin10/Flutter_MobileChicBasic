// ignore_for_file: prefer_const_constructors, unused_field, unused_import, use_build_context_synchronously, duplicate_ignore, non_constant_identifier_names, unused_local_variable, prefer_const_constructors_in_immutables

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/models/user.dart';
import 'package:project_mobile/pages/datauser/datauser.dart';
import 'package:project_mobile/repositories/branch_repository.dart';
import 'package:project_mobile/repositories/user_repository.dart';
import 'package:project_mobile/shared_widgets/error_message.dart';
import 'package:project_mobile/shared_widgets/navigator_widget.dart';
import 'package:project_mobile/shared_widgets/success_message.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

class CreateUser extends StatefulWidget {
  CreateUser({Key? key}) : super(key: key);
  List<XFile>? _imageFileList;

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _formKey = GlobalKey<FormState>();
  int? branchId;

  String textValueFirstname = '';
  String textValueLastname = '';
  String textValuePhone = '';
  String textValueUsername = '';
  String textValuePassword = '';
  String textValueConfirmPassword = '';
  String textValueBranch = '';

  final _branchRepository = BranchRepository();
  Future<List<Branch>?>? branchList;
  @override
  void initState() {
    branchList = _branchRepository.getBranch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Create Branch')),
        // ignore: prefer_const_literals_to_create_immutables
        body: createBody());
  }

  Widget createBody() {
    return FutureBuilder<List<Branch>?>(
      future: branchList!,
      builder: (context, databranch) {
        if (databranch.connectionState == ConnectionState.done) {
          return SingleChildScrollView(
            child: Column(children: [
              // ignore: prefer_const_constructors
              Center(
                // ignore: prefer_const_constructors
                child: Text(
                  "เพิ่มผู้ใช้  ",
                  // ignore: prefer_const_constructors
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text('Img'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอก Username';
                            }
                            textValueUsername = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Username',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกชื่อจริง';
                            }
                            textValueFirstname = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'ชื่อจริง',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกนามสกุล';
                            }
                            textValueLastname = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'นามสกุล',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกเบอร์';
                            }
                            textValuePhone = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'เบอร์โทรศัพท์',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน';
                            }
                            textValuePassword = value;
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'รหัสผ่าน',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'กรุณายืนยันรหัสผ่าน';
                            }
                            textValueConfirmPassword = value;
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'ยืนยันรหัสผ่าน',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        Column(
                          children: [
                            Dropdown(context, (databranch.data ?? [])),
                          ],
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (textValuePassword ==
                                    textValueConfirmPassword) {
                                  await createUser();
                                } else {
                                  showErrorMessage(
                                      context, 'รหัสผ่านไม่ตรงกัน');
                                }
                              }
                            },
                            child: Text('เพิ่มข้อมูล')),
                      ],
                    )),
              )
            ]),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }

  DropdownButtonHideUnderline Dropdown(
      BuildContext context, List<Branch> branchListData) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        hint: Text(
          'Select Item',
          style: TextStyle(
            fontSize: 14,
            color: Theme.of(context).hintColor,
          ),
        ),
        items: branchListData
            // ignore: prefer_const_constructors
            .map((item) => DropdownMenuItem<int>(
                  value: item.id!,
                  // ignore: prefer_const_constructors
                  child: Text(
                    item.namebranch!,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: branchId,
        onChanged: (value) {
          setState(() {
            branchId = value;
          });
        },
        buttonHeight: 40,
        buttonWidth: 140,
        itemHeight: 40,
      ),
    );
  }

  Future<void> createUser() async {
    if (textValuePassword == textValueConfirmPassword) {
      UserRepository userRepository = UserRepository();
      var dataBranch = Branch();
      dataBranch.id = branchId;
      var isSuccess = await userRepository.postUser(User(
        username: textValueUsername,
        firstname: textValueFirstname,
        lastname: textValueLastname,
        phone: textValuePhone,
        passwordHash: textValuePassword,
        passwordSalt: textValuePassword,
        branch: dataBranch,
      ));
      if (isSuccess) {
        showSuccessMessage(context, 'success');
        Navigator.of(context).pushReplacementNamed('/datauser');
      } else {
        showSuccessMessage(context, 'faliled');
      }
    }
  }
}
