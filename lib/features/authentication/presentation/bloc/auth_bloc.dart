import 'package:app_chat_desktop/features/authentication/domain/usecases/register_usecase.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/login_usecase.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;

  AuthBloc(this.loginUsecase, this.registerUsecase) : super(AuthInitial()) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await loginUsecase(event.email, event.password);
      emit(user != null
          ? AuthAuthenticated(user.uid)
          : AuthError("Login failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());

    try {
      final user = await registerUsecase(event.email, event.password);
      emit(user != null
          ? AuthAuthenticated(user.uid)
          : AuthError("Register failed"));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
