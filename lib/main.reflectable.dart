// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.
// @dart = 2.12

import 'dart:core';
import 'package:project_mobile/models/branch.dart' as prefix1;
import 'package:project_mobile/models/user.dart' as prefix2;
import 'package:project_mobile/utils/data_management/reflector.dart' as prefix0;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.Reflector(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'Branch',
            r'.Branch',
            7,
            0,
            const prefix0.Reflector(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) => ({id, namebranch}) =>
                  b ? prefix1.Branch(id: id, namebranch: namebranch) : null,
              r'fromJson': (bool b) =>
                  (json) => b ? prefix1.Branch.fromJson(json) : null
            },
            -1,
            -1,
            const <int>[-1],
            null,
            {
              r'==': 1,
              r'toString': 0,
              r'noSuchMethod': 1,
              r'hashCode': 0,
              r'runtimeType': 0,
              r'toJson': 0,
              r'id': 0,
              r'id=': 1,
              r'namebranch': 0,
              r'namebranch=': 1
            }),
        r.NonGenericClassMirrorImpl(
            r'User',
            r'.User',
            7,
            1,
            const prefix0.Reflector(),
            const <int>[-1],
            null,
            null,
            -1,
            {},
            {},
            {
              r'': (bool b) => (
                      {id,
                      username,
                      passwordHash,
                      passwordSalt,
                      firstname,
                      lastname,
                      phone,
                      img_profile,
                      create_at,
                      update_at,
                      purchase_order,
                      total_sales,
                      branch}) =>
                  b
                      ? prefix2.User(
                          branch: branch,
                          create_at: create_at,
                          firstname: firstname,
                          id: id,
                          img_profile: img_profile,
                          lastname: lastname,
                          passwordHash: passwordHash,
                          passwordSalt: passwordSalt,
                          phone: phone,
                          purchase_order: purchase_order,
                          total_sales: total_sales,
                          update_at: update_at,
                          username: username)
                      : null,
              r'fromJson': (bool b) =>
                  (json) => b ? prefix2.User.fromJson(json) : null
            },
            -1,
            -1,
            const <int>[-1],
            null,
            {
              r'==': 1,
              r'toString': 0,
              r'noSuchMethod': 1,
              r'hashCode': 0,
              r'runtimeType': 0,
              r'toJson': 0,
              r'id': 0,
              r'id=': 1,
              r'username': 0,
              r'username=': 1,
              r'passwordHash': 0,
              r'passwordHash=': 1,
              r'passwordSalt': 0,
              r'passwordSalt=': 1,
              r'firstname': 0,
              r'firstname=': 1,
              r'lastname': 0,
              r'lastname=': 1,
              r'phone': 0,
              r'phone=': 1,
              r'img_profile': 0,
              r'img_profile=': 1,
              r'create_at': 0,
              r'create_at=': 1,
              r'update_at': 0,
              r'update_at=': 1,
              r'purchase_order': 0,
              r'purchase_order=': 1,
              r'total_sales': 0,
              r'total_sales=': 1,
              r'branch': 0,
              r'branch=': 1
            })
      ],
      null,
      null,
      <Type>[prefix1.Branch, prefix2.User],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'toJson': (dynamic instance) => instance.toJson,
        r'id': (dynamic instance) => instance.id,
        r'namebranch': (dynamic instance) => instance.namebranch,
        r'username': (dynamic instance) => instance.username,
        r'passwordHash': (dynamic instance) => instance.passwordHash,
        r'passwordSalt': (dynamic instance) => instance.passwordSalt,
        r'firstname': (dynamic instance) => instance.firstname,
        r'lastname': (dynamic instance) => instance.lastname,
        r'phone': (dynamic instance) => instance.phone,
        r'img_profile': (dynamic instance) => instance.img_profile,
        r'create_at': (dynamic instance) => instance.create_at,
        r'update_at': (dynamic instance) => instance.update_at,
        r'purchase_order': (dynamic instance) => instance.purchase_order,
        r'total_sales': (dynamic instance) => instance.total_sales,
        r'branch': (dynamic instance) => instance.branch
      },
      {
        r'id=': (dynamic instance, value) => instance.id = value,
        r'namebranch=': (dynamic instance, value) =>
            instance.namebranch = value,
        r'username=': (dynamic instance, value) => instance.username = value,
        r'passwordHash=': (dynamic instance, value) =>
            instance.passwordHash = value,
        r'passwordSalt=': (dynamic instance, value) =>
            instance.passwordSalt = value,
        r'firstname=': (dynamic instance, value) => instance.firstname = value,
        r'lastname=': (dynamic instance, value) => instance.lastname = value,
        r'phone=': (dynamic instance, value) => instance.phone = value,
        r'img_profile=': (dynamic instance, value) =>
            instance.img_profile = value,
        r'create_at=': (dynamic instance, value) => instance.create_at = value,
        r'update_at=': (dynamic instance, value) => instance.update_at = value,
        r'purchase_order=': (dynamic instance, value) =>
            instance.purchase_order = value,
        r'total_sales=': (dynamic instance, value) =>
            instance.total_sales = value,
        r'branch=': (dynamic instance, value) => instance.branch = value
      },
      null,
      [
        const [0, 0, null],
        const [1, 0, null],
        const [
          0,
          0,
          const [#id, #namebranch]
        ],
        const [
          0,
          0,
          const [
            #id,
            #username,
            #passwordHash,
            #passwordSalt,
            #firstname,
            #lastname,
            #phone,
            #img_profile,
            #create_at,
            #update_at,
            #purchase_order,
            #total_sales,
            #branch
          ]
        ]
      ])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}
