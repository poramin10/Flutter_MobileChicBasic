// ignore_for_file: non_constant_identifier_names, unused_field, unnecessary_import, avoid_print, no_leading_underscores_for_local_identifiers, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:project_mobile/models/branch.dart';
import 'package:project_mobile/models/user.dart';

class BaseState extends ChangeNotifier {
  List<Branch> branchList = [];
  void setBranchList(List<Branch> branch) {
    branchList = branch;
    notifyListeners();
  }

  List<User> userList = [];
  void setUserList(List<User> user) {
    userList = user;
    notifyListeners();
  }

  int drawerActivePage = 0;




}
