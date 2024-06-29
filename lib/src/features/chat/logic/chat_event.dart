part of 'chat_bloc.dart';

class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SendMsgEvent extends ChatEvent {
  final String message;
  final void Function() scrollListToEnd;

  const SendMsgEvent({required this.message, required this.scrollListToEnd});
}
