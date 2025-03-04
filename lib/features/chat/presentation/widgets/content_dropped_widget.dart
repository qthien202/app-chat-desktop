import 'dart:io';
import 'package:app_chat_desktop/core/di.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_event.dart';
import 'package:app_chat_desktop/utils/app_utils.dart';
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
      if (kIsWeb) {
        if (!FileTypeChecker.isImageByte(snapshot.data!)) {
          return videoThumbnailWeb(file);
        } else {
          return imageWeb(snapshot.data!);
        }
      }

      if (file.path.isNotEmpty && file.path.isImage) {
        return imageDesktop(file);
      }
      if (file.path.isNotEmpty && file.path.isVideo) {
        return videoThumbnail(file);
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
      cancelButton(file)
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
          child: FadeInImage(
            placeholder: AssetImage("assets/images/placeholder.png"),
            image: FileImage(File(file.path)),
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          )),
      cancelButton(file)
    ],
  );
}

Widget cancelButton(DropItem file) {
  return InkWell(
    onTap: () {
      sl<ChatBloc>().add(DeleteFileEvent(file));
    },
    child: Icon(
      Icons.cancel,
      color: Colors.black,
    ),
  );
}

Widget videoThumbnail(DropItem file) {
  return FutureBuilder<String?>(
    future: AppUtils.getVideoThumbnail(File(file.path)),
    builder: (context, snapshot) {
      print(">>>>>>>>thumbnailData: ${snapshot.data}");
      if (snapshot.hasData) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  FadeInImage(
                    placeholder: AssetImage("assets/images/placeholder.png"),
                    image: FileImage(File(snapshot.data!)),
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                  ),
                  Icon(Icons.play_arrow, color: Colors.white, size: 30)
                ],
              ),
            ),
            cancelButton(file)
          ],
        );
      }
      if (snapshot.hasError) return CircularProgressIndicator();
      return Center();
    },
  );
}

Widget videoThumbnailWeb(DropItem file) {
  return FutureBuilder<Uint8List?>(
    future: AppUtils.getVideoThumbnailWeb(File(file.path)),
    builder: (context, snapshot) {
      print(">>>>>>>>thumbnailData: ${snapshot.data}");
      if (snapshot.hasData) {
        return Stack(
          alignment: Alignment.topRight,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.memory(
                    height: 80,
                    width: 80,
                    snapshot.data!,
                    fit: BoxFit.cover,
                  ),
                  Icon(Icons.play_arrow, color: Colors.white, size: 30)
                ],
              ),
            ),
            cancelButton(file)
          ],
        );
      }
      return Center();
    },
  );
}
