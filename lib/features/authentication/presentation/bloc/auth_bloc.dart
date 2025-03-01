import 'package:app_chat_desktop/features/authentication/domain/usecases/sign_in_with_google_usecase.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignInWithGoogleUseCase signInWithGoogleUseCase;
  AuthBloc({required this.signInWithGoogleUseCase}) : super(AuthInitial()) {
    on<SignInWithGoogleEvent>((event, emit) => signInWithGoogle(event, emit));
  }

  Future<void> signInWithGoogle(
      SignInWithGoogleEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await signInWithGoogleUseCase();
      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthError("Signin failed"));
      }
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
