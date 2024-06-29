import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:pharmacy_hub/src/core/api/api_constant.dart';
import 'package:pharmacy_hub/src/core/api/api_consumer.dart';
import 'package:pharmacy_hub/src/features/chat/data/model/chat_model.dart';

class ChatRepository {
  final ApiConsumer _apiConsumer;

  ChatRepository(this._apiConsumer);

  Future<ChatModel> sendMessage({required String message}) async {
    final Response response = await _apiConsumer.post(
      ApiConstant.chatAi,
      queryParameters: {
        'message': message,
      },
    );

    log('message ${response.data['candidates'][0]['content']['parts'][0]['text']}');

    String msg = response.data['candidates'][0]['content']['parts'][0]['text'];

    final ChatModel model = ChatModel(msg: msg, chatIndex: 1);

    return model;
  }
}
