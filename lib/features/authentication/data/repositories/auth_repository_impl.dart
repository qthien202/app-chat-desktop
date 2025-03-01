import '../../domain/repositories/auth_repository.dart';
import '../data_sources/auth_remote_data_source.dart';
import '../models/user_auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel?> login(String email, String password) async {
    final user = await remoteDataSource.login(email, password);
    return user != null ? UserModel.fromFirebase(user) : null;
  }

  @override
  Future<UserModel?> register(String email, String password) async {
    final user = await remoteDataSource.register(email, password);
    return user != null ? UserModel.fromFirebase(user) : null;
  }
}
