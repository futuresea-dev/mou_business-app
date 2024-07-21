// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firebase_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FirebaseMessage _$FirebaseMessageFromJson(Map<String, dynamic> json) =>
    FirebaseMessage(
      type: json['notify_type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      body: json['body'] as String? ?? '',
      routeName: json['route_name'] as String? ?? '',
      arguments: json['arguments'] as String? ?? '',
      action: json['action'] as String? ?? '',
      page: json['page'] as String? ?? '',
      userType: json['user_type'] as String? ?? '',
      avatar: json['avatar'] as String? ?? '',
      isNavigate: json['isNavigate'] as bool? ?? false,
    );

Map<String, dynamic> _$FirebaseMessageToJson(FirebaseMessage instance) =>
    <String, dynamic>{
      'notify_type': instance.type,
      'title': instance.title,
      'body': instance.body,
      'route_name': instance.routeName,
      'arguments': instance.arguments,
      'action': instance.action,
      'page': instance.page,
      'user_type': instance.userType,
      'avatar': instance.avatar,
      'isNavigate': instance.isNavigate,
    };
