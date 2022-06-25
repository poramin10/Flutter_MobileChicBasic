// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      passwordHash: json['passwordHash'] as String?,
      passwordSalt: json['passwordSalt'] as String?,
      firstname: json['firstname'] as String?,
      lastname: json['lastname'] as String?,
      phone: json['phone'] as String?,
      img_profile: json['img_profile'] as String?,
      create_at: json['create_at'] == null
          ? null
          : DateTime.parse(json['create_at'] as String),
      update_at: json['update_at'] == null
          ? null
          : DateTime.parse(json['update_at'] as String),
      purchase_order: json['purchase_order'] as int?,
      total_sales: json['total_sales'] as int?,
      branch: json['branch'] == null
          ? null
          : Branch.fromJson(json['branch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'passwordHash': instance.passwordHash,
      'passwordSalt': instance.passwordSalt,
      'firstname': instance.firstname,
      'lastname': instance.lastname,
      'phone': instance.phone,
      'img_profile': instance.img_profile,
      'create_at': instance.create_at?.toIso8601String(),
      'update_at': instance.update_at?.toIso8601String(),
      'purchase_order': instance.purchase_order,
      'total_sales': instance.total_sales,
      'branch': instance.branch,
    };
