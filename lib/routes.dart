import 'package:app_chat_desktop/features/authentication/presentation/pages/signin_page.dart';
import 'package:app_chat_desktop/features/chat/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(initialLocation: '/home', routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => SignInPage(),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  )
]);
