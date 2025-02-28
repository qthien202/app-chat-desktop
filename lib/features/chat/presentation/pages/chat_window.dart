import 'dart:io';

import 'package:app_chat_desktop/constants/app_data.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_event.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_state.dart';
import 'package:app_chat_desktop/features/chat/presentation/widgets/content_dropped_widget.dart';
import 'package:app_chat_desktop/widgets/message_box_widget.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../widgets/chat_emoji_widget.dart';
import '../../../../widgets/chat_input_widget.dart';

class ChatWindow extends StatelessWidget {
  const ChatWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: appBar(),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              bool isDropping = false;

              if (state is DropFileState) {
                isDropping = state.isDropping;
              }

              return DropTarget(
                onDragEntered: (details) {
                  context.read<ChatBloc>().add(ToggleDropFileEvent(true));
                },
                enable: true,
                onDragDone: (details) {
                  for (var file in details.files) {
                    context.read<ChatBloc>().add(DropFileEvent(file));
                  }
                },
                onDragExited: (details) {
                  context.read<ChatBloc>().add(ToggleDropFileEvent(false));
                },
                child: DottedBorder(
                  padding: EdgeInsets.all(10),
                  color: isDropping ? Colors.blue : Colors.transparent,
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8),
                  borderPadding: EdgeInsets.all(5),
                  strokeWidth: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Expanded(
                        child: messagesWidget(context),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      BlocBuilder<ChatBloc, ChatState>(
                        builder: (context, state) {
                          if (state is DropFileSuccess) {
                            print(">>>>>>>>>>>>>>data: ${state.files.length}");
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border(
                                          bottom: BorderSide(
                                              color: Colors.grey.shade200))),
                                  child: Wrap(
                                      children: state.files.map((file) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5, vertical: 5),
                                      child: contentDroppedWidget(file),
                                    );
                                  }).toList()),
                                ),
                                chatBottomAppBar(context)
                              ],
                            );
                          }
                          return chatBottomAppBar(context);
                        },
                      )
                    ],
                  ),
                ),
              );
            },
          ),
          BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              bool isDropping = state is DropFileState && state.isDropping;
              return isDropping ? dropOverlay() : SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget dropOverlay() {
    return Positioned(
      top: 5,
      left: 5,
      right: 5,
      bottom: 5,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blue.withOpacity(0.5),
            borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload, size: 100, color: Colors.white),
              SizedBox(height: 20),
              Text(
                "Thả file vào đây để xem lại trước khi gửi",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSize appBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    "https://mighty.tools/mockmind-api/content/human/125.jpg"),
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'J2TEAM Community',
                    style: const TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Active now',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          bottom: PreferredSize(
              preferredSize: Size.fromHeight(1),
              child: Divider(
                height: 1,
                color: Colors.grey.shade300,
              )),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.phone_outlined,
                color: Colors.grey,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.video_call_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search_outlined,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ));
  }

  Widget messagesWidget(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.only(bottom: screenHeight * .1),
          itemCount: AppData.messages.length,
          separatorBuilder: (context, index) => const SizedBox(
            height: 10,
          ),
          itemBuilder: (context, index) {
            final message = AppData.messages[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: messageBox(
                isMe: message['sender'] == 'user',
                avatarUrl:
                    "https://mighty.tools/mockmind-api/content/human/125.jpg",
                context: context,
                message: message['message'],
                createdAt: message['timestamp'],
              ),
            );
          },
        );
      },
    );
  }

  Widget chatBottomAppBar(BuildContext context, {bool autoFocus = true}) {
    // final controller = ref.watch(commentControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          color: Colors.white,
          padding: const EdgeInsets.symmetric(
              horizontal: 8), // Thêm padding để tạo không gian
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center, // Đặt align cho Row
            children: [
              // Row(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     GestureDetector(
              //       onTap: () async {},
              //       child: Visibility(
              //         visible: false,
              //         replacement: const PhosphorIcon(
              //           PhosphorIconsRegular.smiley,
              //           color: Colors.grey,
              //           size: 33,
              //         ),
              //         child: const PhosphorIcon(
              //           PhosphorIconsRegular.keyboard,
              //           color: Colors.grey,
              //           size: 33,
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
              // const SizedBox(
              //   width: 10,
              // ),
              Expanded(
                flex: 2,
                child: chatInput(
                  autoFocus: autoFocus,
                  onChanged: (val) {},
                  onTap: () {},
                ),
              ),
              GestureDetector(
                onTap: () async {},
                child: Container(
                  padding: const EdgeInsets.all(
                      8), // Thêm padding để làm cho nút đẹp hơn
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
        Visibility(visible: false, child: chatEmoji(context))
      ],
    );
  }
}
