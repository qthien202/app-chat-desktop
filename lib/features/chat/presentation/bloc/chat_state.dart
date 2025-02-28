import 'package:desktop_drop/desktop_drop.dart';

sealed class ChatState {
  ChatState();
}

class ChatInit extends ChatState {}

class ChatLoading extends ChatState {}

class ChatSuccess extends ChatState {}

class DropFileState extends ChatState {
  final bool isDropping;
  DropFileState(this.isDropping);
}

class DropFileSuccess extends ChatState {
  final List<DropItem> files;

  DropFileSuccess(this.files);
}
