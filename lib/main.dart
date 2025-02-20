import 'package:app_chat_desktop/routes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Window Manager
  await windowManager.ensureInitialized();

  // Đặt kích thước cửa sổ tối thiểu
  windowManager.setMinimumSize(
      const Size(600, 650)); // Min width = 547px, height tùy bạn
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
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
    );
  }
}
