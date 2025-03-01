import 'dart:convert';

import 'package:app_chat_desktop/enviroment/env.dart';
import 'package:app_chat_desktop/features/authentication/data/models/user_auth_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_appauth/flutter_appauth.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel?> signInWithGoogle();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  FlutterAppAuth appAuth = FlutterAppAuth();
  final String redirectUri = 'http://localhost';
  final String discoveryUrl =
      'https://accounts.google.com/.well-known/openid-configuration';

  @override
  Future<UserAuthModel?> signInWithGoogle() async {
    // TODO: implement signInWithGoogle
    try {
      final AuthorizationTokenResponse response =
          await appAuth.authorizeAndExchangeCode(AuthorizationTokenRequest(
        Env.clientId,
        redirectUri,
        discoveryUrl: discoveryUrl,
        scopes: ['openid', 'email', 'profile'],
      ));
      if (response.accessToken == null || response.idToken == null) {
        if (kDebugMode) {
          print('Google Sign-In failed');
        }
        return null;
      }
      final Map<String, dynamic> idTokenPayload =
          parseIdToken(response.idToken ?? "");
      return UserAuthModel(
          uuid: idTokenPayload['sub'],
          name: idTokenPayload['name'],
          avatar: idTokenPayload['picture'],
          accessToken: response.accessToken ?? "",
          idToken: response.idToken ?? "",
          refreshToken: response.refreshToken);
    } catch (e) {
      if (kDebugMode) {
        print('Google Sign-In error: $e');
      }
      return null;
    }
  }

  Map<String, dynamic> parseIdToken(String idToken) {
    final parts = idToken.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid ID token format');
    }
    final payload =
        utf8.decode(base64Url.decode(base64Url.normalize(parts[1])));
    return json.decode(payload);
  }
}
