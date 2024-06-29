import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pharmacy_hub/src/core/enums.dart';
import 'package:pharmacy_hub/src/core/helper.dart';
import 'package:pharmacy_hub/src/core/resources/app_assets.dart';
import 'package:pharmacy_hub/src/core/resources/app_colors.dart';
import 'package:pharmacy_hub/src/features/chat/logic/chat_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final bool isTyping = true;

  final TextEditingController controller = TextEditingController();

  late final ScrollController _scrollController;

  late final FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
    _scrollController = ScrollController();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      scrollListToEnd();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    focusNode.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void scrollListToEnd() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text(
          "Chat Bot",
          style: context.titleSmall,
        ),
      ),
      body: BlocBuilder<ChatBloc, ChatState>(
        builder: (context, state) {
          print(state.sendState);
          return SafeArea(
            top: false,
            right: false,
            left: false,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Flexible(
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.chatList.length,
                      itemBuilder: (context, index) {
                        return ChatWidget(
                          msg: state.chatList[index].msg,
                          chatIndex: state.chatList[index].chatIndex,
                        );
                      },
                    ),
                  ),
                  state.sendState == ReqState.loading
                      ? SpinKitThreeBounce(
                    color: Colors.black,
                    size: 20.w,
                  )
                      : const SizedBox.shrink(),
                  20.verticalSpace,
                  Material(
                    color: Colors.grey.shade100,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: controller,
                              focusNode: focusNode,
                              style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall,
                              onSubmitted: (String value) {
                                /// send message
                                ///
                                context.read<ChatBloc>().add(
                                  SendMsgEvent(
                                    message: controller.text,
                                    scrollListToEnd: scrollListToEnd,
                                  ),
                                );

                                focusNode.unfocus();
                                controller.clear();
                              },
                              decoration: InputDecoration.collapsed(
                                hintText: 'How can i help you?',
                                hintStyle: TextStyle(
                                    color: Colors.grey, fontSize: 16.sp),
                              ),
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            // make box constraints empty
                            style: const ButtonStyle(
                                tapTargetSize:
                                MaterialTapTargetSize.shrinkWrap),
                            onPressed: () {
                              /// send message
                              context.read<ChatBloc>().add(
                                SendMsgEvent(
                                  message: controller.text,
                                  scrollListToEnd: scrollListToEnd,
                                ),
                              );

                              focusNode.unfocus();
                              controller.clear();
                            },
                            icon: const Icon(
                              Icons.send,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class ChatWidget extends StatelessWidget {
  const ChatWidget({
    super.key,
    required this.msg,
    required this.chatIndex,
  });

  final String msg;

  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0
              ? AppColors.primary.withOpacity(0.1)
              : Colors.white,
          child: Padding(
            padding: const EdgeInsetsDirectional.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0 ? AppImages.user : AppImages.chatBot,
                  height: 40.h,
                  width: 40.w,
                  fit: BoxFit.fill,
                ),
                10.horizontalSpace,
                Flexible(
                  child: Text(
                    msg,
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleSmall,
                  ),
                ),

                /*  Expanded(
                  child: chatIndex == 0
                      ? Text(
                          msg,
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      : AnimatedTextKit(
                    repeatForever: false,
                          isRepeatingAnimation: false,
                          totalRepeatCount: 1,
                          animatedTexts: [TyperAnimatedText(msg.trim())],
                        ),
                ),*/
              ],
            ),
          ),
        )
      ],
    );
  }
}
