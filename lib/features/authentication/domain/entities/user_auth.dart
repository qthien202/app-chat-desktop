import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  final String uuid;
  final String name;
  final String avatar;
  final String accessToken;
  final String idToken;
  final String? refreshToken;

  const UserAuth(
      {required this.uuid,
      required this.name,
      required this.avatar,
      required this.accessToken,
      required this.idToken,
      this.refreshToken});

  @override
  List<Object> get props =>
      [uuid, name, avatar, accessToken, idToken, refreshToken ?? ""];

  factory UserAuth.fromJson(Map<String, dynamic> json) {
    return UserAuth(
      uuid: json['uuid'],
      name: json['name'],
      avatar: json['avatar'],
      accessToken: json['accessToken'],
      idToken: json['idToken'],
      refreshToken: json['refreshToken'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uuid': uuid,
      'name': name,
      'avatar': avatar,
      'accessToken': accessToken,
      'idToken': idToken,
      'refreshToken': refreshToken,
    };
  }
}
