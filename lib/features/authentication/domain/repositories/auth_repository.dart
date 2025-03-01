import 'package:app_chat_desktop/features/authentication/domain/entities/user_auth.dart';

abstract class AuthRepository {
  Future<UserEntity?> login(String email, String password);
  Future<UserEntity?> register(String email, String password);
}
