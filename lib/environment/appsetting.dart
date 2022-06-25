// ignore_for_file: unused_import, depend_on_referenced_packages

import 'package:project_mobile/environment/appsetting_file.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appsetting.g.dart';


@JsonSerializable()
class AppSetting { 
  ApiConfig? apiConfig;
  AppSetting(this.apiConfig);
  
  factory AppSetting.fromJson() => _$AppSettingFromJson(appsettingFile); //! appsettingFile เป็น Url API ของเรา
  Map<String , dynamic> toJson() => _$AppSettingToJson(this);
}

@JsonSerializable()
class ApiConfig {
  String? baseUrl;     //! URL ของหลังบ้าน 
  int? receiveTimeout; //! Connect ได้ แต่ไม่มี Response ส่งกลับมาตามเวลาที่กำหนด 
  int? connectTimeout; //! Connect ไม่ได้ ในเวลาที่กำหนด 
  ApiConfig(this.baseUrl,this.receiveTimeout,this.connectTimeout);

  factory ApiConfig.fromJson(Map<String,dynamic> json)=>_$ApiConfigFromJson(json);
  Map<String,dynamic> toJson() => _$ApiConfigToJson(this);
}