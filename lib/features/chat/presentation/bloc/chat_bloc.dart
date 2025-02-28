import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_event.dart';
import 'package:app_chat_desktop/features/chat/presentation/bloc/chat_state.dart';
import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  List<DropItem> droppedFiles = [];
  ChatBloc() : super(ChatInit()) {
    on<ToggleDropFileEvent>((event, emit) => toggleDropFile(event, emit));
    on<DropFileEvent>((event, emit) => dropFile(event, emit));
  }

  toggleDropFile(ToggleDropFileEvent event, Emitter<ChatState> emit) {
    emit(DropFileState(event.isDropping));
  }

  void dropFile(DropFileEvent event, Emitter<ChatState> emit) {
    droppedFiles.add(event.file); // Luôn thêm file mới vào danh sách

    emit(DropFileSuccess(List.from(droppedFiles))); // Emit danh sách mới
  }
}
