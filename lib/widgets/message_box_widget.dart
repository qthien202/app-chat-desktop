import 'package:flutter/material.dart';

Widget messageBox(
    {bool isMe = false,
    required String avatarUrl,
    required BuildContext context,
    required String message,
    required String createdAt}) {
  Color messageColor = isMe ? const Color(0xff3E66FB) : Colors.white;
  final screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Visibility(
            visible: !isMe,
            child: CircleAvatar(
              radius: 15,
              backgroundImage: NetworkImage(avatarUrl),
            )),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: screenWidth * .4),
              child: Container(
                margin: const EdgeInsets.only(bottom: 5),
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                decoration: BoxDecoration(
                  color: messageColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message,
                      style: TextStyle(
                          color: !isMe ? Colors.black : Colors.white,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      createdAt,
                      style: TextStyle(
                          color: !isMe ? Colors.black : Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
