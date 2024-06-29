import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/error/exceptions.dart';
import 'package:pharmacy_hub/src/features/chat/data/model/chat_model.dart';
import 'package:pharmacy_hub/src/features/chat/data/repo/chat_repo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  ChatBloc(this._chatRepository) : super(const ChatState()) {
    on<SendMsgEvent>(_sendMsg);
  }

  final ChatRepository _chatRepository;

  FutureOr<void> _sendMsg(SendMsgEvent event, Emitter<ChatState> emit) async {
    if (event.message.isEmpty) return;

    emit(
      state.copyWith(
        chatList: [
          ...state.chatList,
          ChatModel(msg: event.message, chatIndex: 0)
        ],
      ),
    );

    emit(state.copyWith(sendState: ReqState.loading));
    try {
      ChatModel model =
          await _chatRepository.sendMessage(message: event.message);
      emit(
        state.copyWith(
          chatList: [...state.chatList, model],
          sendState: ReqState.success,
        ),
      );
    } on ServerException catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          sendState: ReqState.error,
        ),
      );
    } finally {
      event.scrollListToEnd();
    }
  }
}
