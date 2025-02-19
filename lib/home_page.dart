import 'package:app_chat_desktop/chat_list.dart';
import 'package:app_chat_desktop/chat_window.dart';
import 'package:app_chat_desktop/side_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          const SideBar(),
          ChatList(),
          Expanded(child: ChatWindow()),
        ],
      ),
    );
  }
}
