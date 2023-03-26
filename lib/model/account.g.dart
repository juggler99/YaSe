// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Account _$AccountFromJson(Map<String, dynamic> json) => Account(
      json['userName'] as String,
      json['title'] as String,
      json['name'] as String,
      json['middlename'] as String,
      json['surname'] as String,
      json['gender'] as String,
      DateTime.parse(json['dob'] as String),
      DateTime.parse(json['registered'] as String),
      json['email'] as String,
      json['phone'] as String,
    );

Map<String, dynamic> _$AccountToJson(Account instance) => <String, dynamic>{
      'userName': instance.userName,
      'title': instance.title,
      'name': instance.name,
      'middlename': instance.middlename,
      'surname': instance.surname,
      'gender': instance.gender,
      'dob': instance.dob.toIso8601String(),
      'email': instance.email,
      'phone': instance.phone,
      'registered': instance.registered.toIso8601String(),
    };
