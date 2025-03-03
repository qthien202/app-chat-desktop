import 'package:app_chat_desktop/enviroment/env.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_event.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_state.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';
import 'package:lottie/lottie.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:window_manager/window_manager.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  Future<void> lockWindowSize() async {
    await windowManager.setMinimumSize(const Size(500, 500));
    await windowManager.setMaximumSize(const Size(500, 500));
    await windowManager.setResizable(false);
  }

  Future<void> unlockWindowSize() async {
    await windowManager.setResizable(true);
    await windowManager
        .setMinimumSize(const Size(300, 300)); // Đặt lại kích thước tối thiểu
    await windowManager
        .setMaximumSize(Size.infinite); // Cho phép mở rộng cửa sổ lại
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
        listener: (context, state) async {
          if (state is AuthInitial) {
            await lockWindowSize();
          } else if (state is AuthAuthenticated) {
            await unlockWindowSize();
            // ignore: use_build_context_synchronously
            context.goNamed('home');
          }
        },
        child: Scaffold(
            backgroundColor: Colors.grey.shade200,
            // backgroundColor: Color(0xff1B202D),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: Lottie.asset("assets/images/chat_splash.json")),
                SizedBox(
                  width: MediaQuery.of(context).size.width * .8,
                  height: 50,
                  child: SignInButton(Buttons.google,
                      text: "Đăng nhập với Google",
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
                      onPressed: () async {
                    context.read<AuthBloc>().add(SignInWithGoogleEvent());
                  }),
                ),
                SizedBox(
                  height: 80,
                ),
                TextButton(
                    onPressed: () async {
                      final GoogleSignIn googleSignIn = GoogleSignIn(
                          params: GoogleSignInParams(
                              clientId: Env.clientId,
                              clientSecret: Env.clientSecret,
                              redirectPort: 8080));
                      await googleSignIn.signOut();
                    },
                    child: Text("Đăng xuất"))
              ],
            )));
  }
}
