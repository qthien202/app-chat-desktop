import 'package:app_chat_desktop/features/chat/presentation/pages/home_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => HomePage(),
  )
]);
