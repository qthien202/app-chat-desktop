import 'package:app_chat_desktop/constants/app_data.dart';
import 'package:app_chat_desktop/widgets/search_widet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ChatList extends StatelessWidget {
  const ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: 350,
      constraints: BoxConstraints(
        minWidth: 350,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          right: BorderSide(
            color: Colors.grey.shade200,
            width: 1,
          ),
        ),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            title: SizedBox(
                width: screenWidth,
                height: 80,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                  child: SearchWidget(),
                )),
            actions: [],
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate(
                  childCount: AppData.chatList.length, (context, index) {
            final chat = AppData.chatList[index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(chat['avatar']),
                ),
                title: Text(
                  chat['name'],
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                subtitle: Text(
                  chat['message'],
                  maxLines: 1,
                ),
                trailing: Text(chat['time']),
              ),
            );
          }))
        ],
      ),
    );
  }
}
