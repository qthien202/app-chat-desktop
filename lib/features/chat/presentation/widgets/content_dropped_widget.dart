import 'dart:io';

import 'package:app_chat_desktop/utils/app_utils.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_chat_desktop/extension/file_type_checker.dart';

Widget contentDroppedWidget(DropItem file) {
  return FutureBuilder<Uint8List?>(
    future: file.readAsBytes(),
    builder: (context, snapshot) {
      if (snapshot.hasData && FileTypeChecker.isImageByte(snapshot.data!)) {
        return Image.memory(
          height: 150,
          width: 150,
          snapshot.data!,
          fit: BoxFit.cover,
        );
      }
      if (!kIsWeb && file.path.isImage) {
        return Image.file(
          height: 150,
          width: 150,
          File(file.path),
          fit: BoxFit.cover,
        );
      }
      return Container(
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
      );
    },
  );
}
