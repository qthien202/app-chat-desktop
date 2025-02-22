import 'package:app_chat_desktop/features/chat/chat_list.dart';
import 'package:app_chat_desktop/features/chat/chat_window.dart';
import 'package:app_chat_desktop/side_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    if (kDebugMode) {
      // print("screenWidth: >>>>>$screenWidth");
      print("screenHeight: >>>>>$screenHeight");
    }
    return Container(
      constraints: BoxConstraints(
        minWidth: 547,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          children: [
            const SideBar(),
            Visibility(visible: screenWidth > 900, child: ChatList()),
            Expanded(child: ChatWindow()),
          ],
        ),
      ),
    );
  }
}
