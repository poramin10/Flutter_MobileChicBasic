// ignore_for_file: prefer_const_constructors, unused_field, unused_import, use_build_context_synchronously, duplicate_ignore, non_constant_identifier_names, unused_local_variable, prefer_const_constructors_in_immutables, duplicate_import, unnecessary_import, unused_element
import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/models/param/create_evaluation_param.dart';
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
  XFile? _imageFile;

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

  //  IMG
  XFile? _imageFile;
  bool checkImg = false;
  void _setImageFileListFromFile(XFile? value) {
    _imageFile = value == null ? null : value;
  }

  dynamic _pickImageError;
  String? _retrieveDataError;
  final ImagePicker _picker = ImagePicker();

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, bool isMultiImage = false}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 250,
        maxHeight: 250,
        imageQuality: 20,
      );
      setState(() {
        _setImageFileListFromFile(pickedFile);
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  // ? --> ?????????????????????????????? Preview ??????????????????
  Widget _previewImages() {
    // ? --> ??????????????????????????? Error ?????????????????????????????????
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
                          backgroundImage: FileImage(File(_imageFile!.path)),
                          radius: 110,
                        ),
                        onTap: () {
                          _onImageButtonPressed(ImageSource.gallery,
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
            backgroundImage: AssetImage('assets/images/img-preview.jpg'),
            radius: 110,
          ),
        ),
        onTap: () {
          _onImageButtonPressed(ImageSource.gallery, context: context);
        },
      );
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

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
              Center(
                child: Text(
                  "?????????????????????????????????  ",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
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
                        SizedBox(height: 20),
                        Center(
                          child: _previewImages(),
                        ),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '??????????????????????????? Username';
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
                              return '???????????????????????????????????????????????????';
                            }
                            textValueFirstname = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '????????????????????????',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '????????????????????????????????????????????????';
                            }
                            textValueLastname = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '?????????????????????',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '??????????????????????????????????????????';
                            }
                            textValuePhone = value;
                            return null;
                          },
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '???????????????????????????????????????',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '???????????????????????????????????????????????????';
                            }
                            textValuePassword = value;
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '????????????????????????',
                          ),
                        ),
                        Padding(padding: EdgeInsets.all(8.0)),
                        TextFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return '?????????????????????????????????????????????????????????';
                            }
                            textValueConfirmPassword = value;
                            return null;
                          },
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: '??????????????????????????????????????????',
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
                                      context, '???????????????????????????????????????????????????');
                                }
                              }
                            },
                            child: Text('?????????????????????????????????')),
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
      var formData = FormData();
      var file = await MultipartFile.fromFile(_imageFile!.path,
          filename: _imageFile!.name);
      formData.files.add(MapEntry(
        'locationFiles',
        file,
      ));
      var result = await userRepository.postImg(formData);
      if (result.success ?? false) {
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
            img_profile: result.data as String));
        if (isSuccess) {
          showSuccessMessage(context, 'success');
          Navigator.of(context).pushReplacementNamed('/datauser');
        } else {
          showSuccessMessage(context, 'faliled');
        }
      } else {
        showErrorMessage(context, '???????????????????????????');
      }
    }
  }
}
