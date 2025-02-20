import 'package:flutter/material.dart';

Widget chatInput(
    {void Function(String)? onChanged,
    void Function()? onTap,
    bool autoFocus = true}) {
  return Container(
    // padding: EdgeInsets.a,
    child: TextField(
      onTap: onTap,
      // autofocus:
      //     controller.isShowMedia || controller.isShowEmoji ? false : true,
      // controller: controller.contentController,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      textAlignVertical: TextAlignVertical.center,
      onChanged: onChanged,
      keyboardType: TextInputType.multiline,
      maxLines: null,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 20),
        hintText: "Nhập tin nhắn...",
        hintStyle: const TextStyle(fontSize: 14),
        enabledBorder: InputBorder.none,
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
    ),
  );
}
