part of 'chat_bloc.dart';

class ChatState extends Equatable {
  final List<ChatModel> chatList;

  final String errorMessage;

  final ReqState sendState;

  const ChatState({
    this.chatList = const [],
    this.errorMessage = "",
    this.sendState = ReqState.empty,
  });

  ChatState copyWith({
    List<ChatModel>? chatList,
    String? errorMessage,
    ReqState? sendState,
  }) {
    return ChatState(
      chatList: chatList ?? this.chatList,
      errorMessage: errorMessage ?? this.errorMessage,
      sendState: sendState ?? this.sendState,
    );
  }

  @override
  List<Object> get props => [
        chatList,
        errorMessage,
        sendState,
      ];
}
