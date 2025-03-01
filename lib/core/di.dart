import 'package:app_chat_desktop/features/authentication/data/data_sources/auth_remote_data_source.dart';
import 'package:app_chat_desktop/features/authentication/data/repositories/auth_repository_impl.dart';
import 'package:app_chat_desktop/features/authentication/domain/repositories/auth_repository.dart';
import 'package:app_chat_desktop/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;
void initializeDependencie() {
  sl.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl());
  sl.registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(sl<AuthRemoteDataSource>()));
  sl.registerLazySingleton(() => SignInWithGoogleUseCase(sl<AuthRepository>()));
  sl.registerFactory(
      () => AuthBloc(signInWithGoogleUseCase: sl<SignInWithGoogleUseCase>()));
}
