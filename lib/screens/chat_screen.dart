import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_chat/providers/chats_provider.dart';
import 'package:gpt_chat/widgets/chat_box.dart';
import 'package:gpt_chat/widgets/my_appbar.dart';

import '../widgets/text_and_voice_field.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(builder: (context, ref, child) {
              final chats = ref.watch(chatProvider).reversed.toList();
              return ListView.builder(
                reverse: true,
                itemCount: chats.length,
                itemBuilder: (context, index) {
                  return ChatItem(text: chats[index].message, isMe: chats[index].isMe);
                },
              );
            }),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            child: TextAndVoiceField(),
          ),
        ],
      ),
    );
  }
}
