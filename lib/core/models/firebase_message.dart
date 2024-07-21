import 'package:json_annotation/json_annotation.dart';

part 'firebase_message.g.dart';

@JsonSerializable()
class FirebaseMessage {
  @JsonKey(name: 'notify_type')
  String type;
  String title;
  String body;
  @JsonKey(name: 'route_name')
  String routeName;
  String arguments;
  String action;
  String page;
  @JsonKey(name: 'user_type')
  String userType;
  String avatar;
  bool isNavigate;

  FirebaseMessage({
    this.type = '',
    this.title = '',
    this.body = '',
    this.routeName = '',
    this.arguments = '',
    this.action = '',
    this.page = '',
    this.userType = '',
    this.avatar = '',
    this.isNavigate = false,
  });

  FirebaseMessage copyWith({
    String? type,
    String? title,
    String? body,
    String? routeName,
    String? arguments,
    String? action,
    String? page,
    String? userType,
    String? avatar,
    bool? isNavigate,
  }) =>
      FirebaseMessage(
        type: type ?? this.type,
        title: title ?? this.title,
        body: body ?? this.body,
        routeName: routeName ?? this.routeName,
        arguments: arguments ?? this.arguments,
        action: action ?? this.action,
        page: page ?? this.page,
        userType: userType ?? this.userType,
        avatar: avatar ?? this.avatar,
        isNavigate: isNavigate ?? this.isNavigate,
      );

  factory FirebaseMessage.fromJson(Map<String, dynamic> json) => _$FirebaseMessageFromJson(json);

  Map<String, dynamic> toJson() => _$FirebaseMessageToJson(this);
}
