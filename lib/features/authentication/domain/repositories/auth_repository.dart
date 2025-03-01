import 'package:app_chat_desktop/features/authentication/domain/entities/user_auth.dart';

abstract class AuthRepository {
  Future<UserAuth?> signInWithGoogle();
}
