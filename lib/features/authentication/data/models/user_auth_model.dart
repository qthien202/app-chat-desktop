import 'package:app_chat_desktop/features/authentication/domain/entities/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuthModel extends UserAuth {
  const UserAuthModel({
    required super.uuid,
    required super.name,
    required super.avatar,
    required super.accessToken,
    required super.idToken,
    super.refreshToken,
  });

  factory UserAuthModel.fromUserAuth(UserAuth user) {
    return UserAuthModel(
      uuid: user.uuid,
      name: user.name,
      avatar: user.avatar,
      accessToken: user.accessToken,
      idToken: user.idToken,
      refreshToken: user.refreshToken,
    );
  }
}
