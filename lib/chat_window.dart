import 'package:flutter/material.dart';

class ChatWindow extends StatelessWidget {
  const ChatWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: CustomScrollView(
        slivers: [appBar()],
      ),
    );
  }

  Widget appBar() {
    return SliverAppBar(
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
          preferredSize: Size.fromHeight(20),
          child: Divider(
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
    );
  }
}
