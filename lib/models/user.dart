// ignore_for_file: depend_on_referenced_packages, non_constant_identifier_names

import 'package:project_mobile/models/branch.dart';

import 'package:project_mobile/utils/data_management/reflector.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@reflector
@JsonSerializable()
class User {
  int? id;
  String? username;
  String? passwordHash = '-';
  String? passwordSalt = '-';
  String? firstname;
  String? lastname;
  String? phone;
  String? img_profile = 'image';
  DateTime? create_at = DateTime.now();
  DateTime? update_at = DateTime.now();
  int? purchase_order = 0;
  int? total_sales = 0;

  Branch? branch;

  User(
      {this.id,
      this.username,
      this.passwordHash,
      this.passwordSalt,
      this.firstname,
      this.lastname,
      this.phone,
      String? img_profile,
      DateTime? create_at,
      DateTime? update_at,
      int? purchase_order,
      int? total_sales,
      this.branch});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
