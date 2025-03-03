import 'package:flutter/material.dart';

Widget chatInput(
    {void Function(String)? onChanged,
    void Function()? onTap,
    bool autoFocus = true}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: SizedBox(
      height: 40,
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
          contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          hintText: "Nhập tin nhắn...",
          hintStyle: const TextStyle(fontSize: 14),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade200)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(color: Colors.grey.shade200)),
        ),
      ),
    ),
  );
}
