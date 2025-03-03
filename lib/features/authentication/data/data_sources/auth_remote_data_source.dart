import 'package:app_chat_desktop/enviroment/env.dart';
import 'package:app_chat_desktop/features/authentication/data/models/user_auth_model.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in_all_platforms/google_sign_in_all_platforms.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel?> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Future<UserAuthModel?> signInWithGoogle() async {
    try {
      // 1️⃣ Mở trình duyệt để người dùng đăng nhập Google
      final GoogleSignIn googleSignIn = GoogleSignIn(
          params: GoogleSignInParams(
              clientId: Env.clientId,
              clientSecret: Env.clientSecret,
              redirectPort: 8080));

      final googleAuth = await googleSignIn.signIn();
      // 3️⃣ Xác thực với Firebase
      if (googleAuth == null) {
        throw Exception("Google authentication failed.");
      }
      print(">>>>>>>>>idToken: ${googleAuth.idToken}");
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user == null) return null;

      return UserAuthModel(
        uuid: user.uid,
        name: user.displayName ?? "No Name",
        avatar: user.photoURL ?? "",
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken ?? "",
        refreshToken: user.refreshToken ?? "",
      );
    } catch (e) {
      if (kDebugMode) {
        print('Google Sign-In error: $e');
      }
      return null;
    }
  }
}
