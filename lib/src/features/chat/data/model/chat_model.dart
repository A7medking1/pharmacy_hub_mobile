import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String msg;

  final int chatIndex;

  const ChatModel({
    required this.msg,
    required this.chatIndex,
  });

  @override
  List<Object> get props => [msg, chatIndex];
}
