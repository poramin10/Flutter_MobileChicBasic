// ignore_for_file: prefer_const_constructors, unused_import, camel_case_types, non_constant_identifier_names, unused_local_variable, no_leading_underscores_for_local_identifiers, duplicate_ignore, void_checks, prefer_if_null_operators, use_build_context_synchronously

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  String createImgPath(serverPath) {
    //! ต้อง Replace ด้วย เพราะ Flutter ไม่ได้ปรับให้
    return 'https://192.168.1.181:5001/$serverPath'.replaceAll('\\', '/');
  }

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

  StatefulBuilder EditUserForm(User d, GlobalKey<FormState> formKey,
      BuildContext context, BaseState baseState) {
    // String textValueUsername = '';
    final _valueUsername = TextEditingController();
    print(createImgPath(d.img_profile));

    XFile? _imageFile;
    bool checkImg = false;
    dynamic _pickImageError;
    String? _retrieveDataError;
    final ImagePicker _picker = ImagePicker();

    return StatefulBuilder(builder: (context, setState) {
      void _setImageFileListFromFile(XFile? value) {
        _imageFile = value == null ? null : value;
      }

      Text? _getRetrieveErrorWidget() {
        if (_retrieveDataError != null) {
          final Text result = Text(_retrieveDataError!);
          _retrieveDataError = null;
          return result;
        }
        return null;
      }

      Future<void> _onImageButtonPressedAlert(ImageSource source,
          {BuildContext? context, bool isMultiImage = false}) async {
        try {
          final XFile? pickedFile = await _picker.pickImage(
            source: source,
            maxWidth: 250,
            maxHeight: 250,
            imageQuality: 20,
          );
          setState.call(() {
            _setImageFileListFromFile(pickedFile);
          });
        } catch (e) {
          setState(() {
            _pickImageError = e;
          });
        }
      }

      Widget _previewImages(String? imgProfile) {
        // ? --> เช็คว่ามี Error อะไรรึเปล่า
        final Text? retrieveError = _getRetrieveErrorWidget();
        if (retrieveError != null) {
          return retrieveError;
        }
        if (_imageFile != null) {
          print(_imageFile!.path);
          return Semantics(
              label: 'image_picker_example_picked_images',
              child: Semantics(
                label: 'image_picker_example_picked_image',
                child: kIsWeb
                    ? Image.network(_imageFile!.path)
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            child: CircleAvatar(
                              backgroundImage:
                                  FileImage(File(_imageFile!.path)),
                              radius: 110,
                            ),
                            onTap: () {
                              _onImageButtonPressedAlert(ImageSource.gallery,
                                  context: context);
                            },
                          ),
                        ],
                      ),
              ));
        } else if (_pickImageError != null) {
          return Text(
            'Pick image error: $_pickImageError',
            textAlign: TextAlign.center,
          );
        } else {
          return GestureDetector(
            child: CircleAvatar(
              radius: 112,
              backgroundColor: Color.fromARGB(255, 0, 0, 0),
              child: CircleAvatar(
                backgroundImage: NetworkImage(createImgPath(imgProfile)),
                radius: 110,
              ),
            ),
            onTap: () {
              _onImageButtonPressedAlert(ImageSource.gallery, context: context);
            },
          );
        }
      }

      // setState.call(() {
      //   _setImageFileListFromFile(pickedFile);
      // });

      return AlertDialog(
        title: Text('ผู้ใช้: ${d.firstname} ${d.lastname}'),
        content: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  _previewImages(d.img_profile),
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
                UserRepository userRepository = UserRepository();

                var formData = FormData();
                var file = await MultipartFile.fromFile(_imageFile!.path,
                    filename: _imageFile!.name);
                print(file);
                formData.files.add(MapEntry(
                  'locationFiles',
                  file,
                ));
                var result = await userRepository.postImg(formData);
                if (result.success ?? false) {
                  print('Upload Success');
                  print(result);

                  formKey.currentState!.save();
                  d.img_profile = result.data;
                  d.firstname = firstname;
                  d.lastname = lastname;
                  d.phone = phone;
                  d.branch!.id =
                      branchIdActive == null ? d.branch!.id : branchIdActive;
                  await updateUser(d);
                }

                // setState(() {});
              }
            },
            child: const Text('OK'),
          ),
        ],
      );
    });
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
