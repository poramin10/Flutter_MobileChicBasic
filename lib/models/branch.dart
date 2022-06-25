// ignore_for_file: unused_import, depend_on_referenced_packages, invalid_annotation_target

import 'package:project_mobile/utils/data_management/reflector.dart';
import 'package:json_annotation/json_annotation.dart';

part 'branch.g.dart';

@reflector
@JsonSerializable()
class Branch {
  int? id;
  String? namebranch;
  Branch({this.id, this.namebranch});
  
  factory Branch.fromJson(Map<String, dynamic> json) => _$BranchFromJson(json);
  Map<String, dynamic> toJson() => _$BranchToJson(this);
}
