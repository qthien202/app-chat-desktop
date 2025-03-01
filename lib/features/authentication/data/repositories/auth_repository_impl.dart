import 'package:app_chat_desktop/features/authentication/domain/entities/user_auth.dart';

import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserAuth?> signInWithGoogle() async {
    final userModel = await remoteDataSource.signInWithGoogle();
    return userModel != null ? UserAuth.fromJson(userModel.toJson()) : null;
  }
}
