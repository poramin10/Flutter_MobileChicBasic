// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appsetting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSetting _$AppSettingFromJson(Map<String, dynamic> json) => AppSetting(
      json['apiConfig'] == null
          ? null
          : ApiConfig.fromJson(json['apiConfig'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppSettingToJson(AppSetting instance) =>
    <String, dynamic>{
      'apiConfig': instance.apiConfig,
    };

ApiConfig _$ApiConfigFromJson(Map<String, dynamic> json) => ApiConfig(
      json['baseUrl'] as String?,
      json['receiveTimeout'] as int?,
      json['connectTimeout'] as int?,
    );

Map<String, dynamic> _$ApiConfigToJson(ApiConfig instance) => <String, dynamic>{
      'baseUrl': instance.baseUrl,
      'receiveTimeout': instance.receiveTimeout,
      'connectTimeout': instance.connectTimeout,
    };
