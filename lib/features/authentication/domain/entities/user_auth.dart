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
}
