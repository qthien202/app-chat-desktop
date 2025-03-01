import 'package:app_chat_desktop/features/authentication/domain/entities/user_auth.dart';
import 'package:app_chat_desktop/features/authentication/domain/repositories/auth_repository.dart';

class LoginUsecase {
  final AuthRepository repository;
  LoginUsecase(this.repository);

  Future<UserEntity?> call(String email, String password) async {
    return await repository.login(email, password);
  }
}
