// ignore_for_file: prefer_const_constructors, unused_import, camel_case_types, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, duplicate_ignore, void_checks, prefer_if_null_operators, use_build_context_synchronously

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/models/user.dart';
import 'package:project_mobile/pages/createuser/createuser.dart';
import 'package:project_mobile/repositories/branch_repository.dart';
import 'package:project_mobile/repositories/user_repository.dart';
import 'package:project_mobile/shared_widgets/error_message.dart';
import 'package:project_mobile/shared_widgets/navigator_widget.dart';
import 'package:project_mobile/shared_widgets/success_message.dart';
import 'package:project_mobile/state/base_state.dart';
import 'package:provider/provider.dart';

class DataUser extends StatefulWidget {
  DataUser({Key? key}) : super(key: key);
  // int? branchId;

  @override
  State<DataUser> createState() => _DataUserState();
}

class _DataUserState extends State<DataUser> {
  String? firstname, lastname, phone;
  int? branchId;
  final UserRepository _userRepository = UserRepository();
  final BranchRepository _branchRepository = BranchRepository();
  int? branchIdActive;

  Future<void> getUser() async {
    var userList = await _userRepository.getUser() ?? [];
    var branchList = await _branchRepository.getBranch() ?? [];
     Provider.of<BaseState>(context, listen: false).setUserList(userList);
    Provider.of<BaseState>(context, listen: false).setBranchList(branchList);
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(title: Text('DataUser')),
      body: FutureBuilder<void>(
          future: getUser(),
          builder: (context, datauser) {
            if (datauser.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (datauser.hasError) {
              return Center(child: Text((datauser.error.toString())));
            } else {
              return Consumer<BaseState>(builder: (context, baseState, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CreateUser()),
                                );
                              },
                              child: Text('เพิ่มผู้ใช้งาน  '))
                        ],
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(
                          columns: const <DataColumn>[
                            DataColumn(
                              label: Text(
                                'ชื่อจริง',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'นามสกุล',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'สาขา',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                'Action',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                          rows: <DataRow>[
                            ...(baseState.userList)
                                .map(
                                  (d) => DataRow(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    cells: <DataCell>[
                                      DataCell(Text(d.firstname!)),
                                      DataCell(Text(d.lastname!)),
                                      DataCell(Text(d.branch!.namebranch!)),
                                      DataCell(Row(
                                        children: [
                                          Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(17.5),
                                              onTap: () => showDialog<String>(
                                                context: context,
                                                builder:
                                                    (BuildContext context) =>
                                                        EditUserForm(
                                                  d,
                                                  formKey,
                                                  context,
                                                  baseState,
                                                ),
                                              ),
                                              child: Center(
                                                  child: Icon(Icons.edit)),
                                            ),
                                          ),
                                          Container(
                                            height: 35,
                                            width: 35,
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.red),
                                            child: InkWell(
                                              borderRadius:
                                                  BorderRadius.circular(17.5),
                                              onTap: () async {
                                                bool? deleteConfirm =
                                                    await showDialog<bool>(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) =>
                                                          DeleteUserForm(
                                                              d,
                                                              context,
                                                              baseState),
                                                );
                                                if (deleteConfirm ?? false) {
                                                  await deleteUser(d);
                                                }
                                              },
                                              child: Center(
                                                  child: Icon(Icons.delete)),
                                            ),
                                          ),
                                        ],
                                      )),
                                    ],
                                  ),
                                )
                                .toList(),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
            }
          }),
      drawer: Navigation(),
    );
  }

  AlertDialog DeleteUserForm(
      User d, BuildContext context, BaseState baseState) {
    return AlertDialog(
      title: Text('Alert'),
      content:
          Text('คุณแน่ใจหรือไม่ \nว่าจะลบคุณ ${d.firstname} ${d.lastname}'),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () async {
            Navigator.pop(context, true);
            // await baseState.deleteUser(d);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  AlertDialog EditUserForm(User d, GlobalKey<FormState> formKey,
      BuildContext context, BaseState baseState) {
    // String textValueUsername = '';

    final _valueUsername = TextEditingController();

    return AlertDialog(
      title: Text('ผู้ใช้: ${d.firstname} ${d.lastname}'),
      content: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  enabled: false,
                  initialValue: "${d.username}",
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'Username',
                  ),
                ),
                TextFormField(
                  initialValue: "${d.firstname}",
                  validator: (value) {
                    // RegExp regex = new RegExp(r'^.{3,}$');
                    if (value!.isEmpty) {
                      return ("กรุณากรอกชื่อผู้ใช้");
                    }
                    // if (!regex.hasMatch(value)) {
                    //   return ("กรุณากรอกชื่อผู้ใช้มากกว่า 3 ตัวอักษร");
                    // }
                    return null;
                  },
                  onSaved: (String? firstnameValue) {
                    firstname = firstnameValue!;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'ชื่อ',
                  ),
                ),
                TextFormField(
                  initialValue: "${d.lastname}",
                  onSaved: (String? lastnameValue) {
                    lastname = lastnameValue!;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'นามสกุล',
                  ),
                ),
                TextFormField(
                  initialValue: "${d.phone}",
                  onSaved: (String? phoneValue) {
                    phone = phoneValue!;
                  },
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'เบอร์โทร',
                  ),
                ),
                Dropdown(context, baseState, branchId, d.branch!.id!),
              ],
            ),
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel')),
        TextButton(
          onPressed: () async {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              d.firstname = firstname;
              d.lastname = lastname;
              d.phone = phone;
              d.branch!.id =
                  branchIdActive == null ? d.branch!.id : branchIdActive;
              await updateUser(d);
              // setState(() {});
            }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }

  Future<void> updateUser(User edituser) async {
    var isSuccess = await _userRepository.putUser(edituser);
    if (isSuccess) {
      showSuccessMessage(context, 'แก้ไขสำเร็จ');
      await getUser();
    } 
    
  }

  Future<void> deleteUser(User deleteuser) async {
    var isSuccess = await _userRepository.deleteUser(deleteuser);
    if (isSuccess) {
      showSuccessMessage(context, 'ลบสำเร็จ');
      await getUser();
    } else {
      showErrorMessage(context, 'ลบไม่สำเร็จ');
    }
    
  }

  Widget Dropdown(BuildContext context, BaseState baseState, int? branchId,
      activeBranchId) {
    return StatefulBuilder(builder: (context, setState) {
      return DropdownButtonHideUnderline(
        child: DropdownButton2<int>(
          hint: Text(
            'Select Item',
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).hintColor,
            ),
          ),
          items: baseState.branchList
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
          value: activeBranchId,
          onChanged: (value) {
            setState(() {
              activeBranchId = value;
              branchIdActive = value;
            });
          },
          buttonHeight: 40,
          buttonWidth: 140,
          itemHeight: 40,
        ),
      );
    });
  }
}



// ignore_for_file: unused_import, prefer_const_constructors_in_immutables, prefer_const_constructors, unused_field
