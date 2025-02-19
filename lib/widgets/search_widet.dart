import 'package:app_chat_desktop/constants/app_colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchWidget extends StatelessWidget {
  final Color? fillColor;
  final void Function()? onTap;
  final void Function(String)? onSubmitted;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  bool? readOnly;
  bool? autofocus;
  SearchWidget(
      {super.key,
      this.onTap,
      this.onSubmitted,
      this.onChanged,
      this.readOnly,
      this.controller,
      this.autofocus,
      this.fillColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        cursorColor: AppColors.primaryColor,
        autofocus: autofocus ?? false,
        onTap: onTap,
        onSubmitted: onSubmitted,
        onChanged: onChanged,
        controller: controller,
        readOnly: readOnly ?? false,
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          prefixIcon: Icon(Icons.search),
          filled: true,
          fillColor: fillColor ?? Colors.transparent,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide(
              color: Colors.grey.shade300,
            ),
          ),
        ),
      ),
    );
  }
}
