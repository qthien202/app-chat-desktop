import 'package:app_chat_desktop/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    List<Map<String, dynamic>> items = [
      {"icon": PhosphorIconsFill.chatCircleText, "title": "Message"},
      {"icon": PhosphorIconsFill.addressBook, "title": "Contact"},
      {"icon": PhosphorIconsFill.magnifyingGlass, "title": "search"},
      {"icon": PhosphorIconsFill.gearSix, "title": "Settings"},
    ];
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10),
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      height: screenHeight,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundImage: const NetworkImage(
                  "https://mighty.tools/mockmind-api/content/human/104.jpg"),
            ),
            const SizedBox(height: 40),
            Column(
              children: items
                  .map((item) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: IconButton(
                          onPressed: () {},
                          icon: PhosphorIcon(
                            size: 30,
                            item["icon"],
                            color: Colors.white,
                          ),
                        ),
                      ))
                  .toList(),
            )
          ],
        ),
      ),
    );
  }
}
