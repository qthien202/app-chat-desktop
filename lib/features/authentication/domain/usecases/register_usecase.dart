import 'package:app_chat_desktop/features/authentication/domain/entities/user.dart';

import '../repositories/auth_repository.dart';

class RegisterUsecase {
  final AuthRepository repository;
  RegisterUsecase(this.repository);

  Future<UserEntity?> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
