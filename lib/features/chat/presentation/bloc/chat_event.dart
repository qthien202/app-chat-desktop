import 'package:desktop_drop/desktop_drop.dart';
import 'package:image_picker/image_picker.dart';

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
