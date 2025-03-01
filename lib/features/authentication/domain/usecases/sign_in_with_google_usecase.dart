import 'package:app_chat_desktop/features/authentication/domain/entities/user_auth.dart';
import 'package:app_chat_desktop/features/authentication/domain/repositories/auth_repository.dart';

class SignInWithGoogleUseCase {
  final AuthRepository repository;
  SignInWithGoogleUseCase(this.repository);

  Future<UserAuth?> call() async => await repository.signInWithGoogle();
}
