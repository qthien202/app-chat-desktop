import 'package:app_chat_desktop/core/di.dart';
import 'package:app_chat_desktop/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:app_chat_desktop/firebase_options.dart';
import 'package:app_chat_desktop/routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDependencie();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Khởi tạo Window Manager
  if (!kIsWeb) {
    await windowManager.ensureInitialized();
    // await dotenv.load(fileName: ".env");
    // Đặt kích thước cửa sổ tối thiểu
    windowManager.setMinimumSize(const Size(600, 650));
  } // Min width = 547px, height tùy bạn
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<AuthBloc>(),
        ),
        BlocProvider(create: (context) => ChatBloc())
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        builder: (context, child) => ResponsiveBreakpoints.builder(
          child: child!,
          breakpoints: [
            const Breakpoint(
                start: 800, end: 1200, name: 'LAPTOP_SMALL'), // Laptop nhỏ
            const Breakpoint(
                start: 1201,
                end: 1920,
                name: DESKTOP), // Màn hình desktop tiêu chuẩn
            const Breakpoint(
                start: 1921,
                end: double.infinity,
                name: 'LARGE_SCREEN'), // Màn hình lớn
          ],
        ),
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routerConfig: router,
      ),
    );
  }
}
