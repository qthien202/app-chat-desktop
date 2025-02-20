import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';

Widget chatEmoji(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;

  return EmojiPicker(
    onEmojiSelected: (category, emoji) {},
    onBackspacePressed: () {},
    config: Config(
      height: screenHeight * .32,
      checkPlatformCompatibility: true,
      skinToneConfig: const SkinToneConfig(),
      categoryViewConfig: const CategoryViewConfig(),
      bottomActionBarConfig: const BottomActionBarConfig(),
      searchViewConfig: const SearchViewConfig(),
    ),
  );
}
