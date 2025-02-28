import 'dart:io';

import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:app_chat_desktop/extension/file_type_checker.dart';

Widget contentDroppedWidget(DropItem file) {
  return Visibility(
    visible: file.path.isImage,
    replacement: Container(
      height: 150,
      width: 150,
      color: Colors.grey.shade200,
      padding: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.file_present,
            size: 30,
            color: Colors.blue,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(file.name)
        ],
      ),
    ),
    child: Image.file(
      height: 150,
      width: 150,
      File(file.path),
      fit: BoxFit.cover,
    ),
  );
}
