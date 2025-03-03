import 'package:desktop_drop/desktop_drop.dart';

sealed class ChatEvent {
  ChatEvent();
}

class ToggleDropFileEvent extends ChatEvent {
  final bool isDropping;
  ToggleDropFileEvent(this.isDropping);
}

class DropFileEvent extends ChatEvent {
  final DropItem file;
  DropFileEvent(this.file);
}
