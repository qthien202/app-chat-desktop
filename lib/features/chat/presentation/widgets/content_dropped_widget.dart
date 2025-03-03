import 'dart:io';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:app_chat_desktop/extension/file_type_checker.dart';

Widget contentDroppedWidget(DropItem file) {
  final Future<Uint8List?> fileBytesFuture = file.readAsBytes();
  return FutureBuilder<Uint8List?>(
    future: fileBytesFuture,
    builder: (context, snapshot) {
      // print(">>>>>>>>>>>>uint8List: ${snapshot.data}");
      if (kIsWeb &&
          snapshot.hasData &&
          FileTypeChecker.isImageByte(snapshot.data!)) {
        return imageWeb(snapshot.data!);
      }

      if (file.path.isNotEmpty && file.path.isImage) {
        return imageDesktop(file);
      }
      return contentFile(file);
    },
  );
}

Widget contentFile(DropItem file) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      Container(
        constraints: BoxConstraints(maxWidth: 150),
        height: 50,
        // width: 80,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(5),
        child: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 30,
              color: Colors.white,
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    file.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Icon(Icons.cancel)
    ],
  );
}

Widget imageWeb(Uint8List imageByte) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.memory(
      height: 80,
      width: 80,
      imageByte,
      fit: BoxFit.cover,
    ),
  );
}

Widget imageDesktop(DropItem file) {
  return Stack(
    alignment: Alignment.topRight,
    children: [
      ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          height: 80,
          width: 80,
          File(file.path),
          fit: BoxFit.cover,
        ),
      ),
      Icon(
        Icons.cancel,
        color: Colors.black,
      )
    ],
  );
}
