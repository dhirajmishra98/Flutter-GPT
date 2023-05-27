import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gpt_chat/models/chat_model.dart';
import 'package:gpt_chat/providers/chats_provider.dart';
import 'package:gpt_chat/services/ai_handler.dart';
import 'package:gpt_chat/services/voice_handler.dart';
import 'package:gpt_chat/widgets/toggle_input_modes.dart';

enum InputMode {
  text,
  voice,
}

class TextAndVoiceField extends ConsumerStatefulWidget {
  const TextAndVoiceField({super.key});

  @override
  ConsumerState<TextAndVoiceField> createState() => _TextAndVoiceFieldState();
}

class _TextAndVoiceFieldState extends ConsumerState<TextAndVoiceField> {
  final TextEditingController _messageController = TextEditingController();
  InputMode _inputMode = InputMode.voice;
  final OpenAIService _aiHandler = OpenAIService();
  final VoiceHandler _voiceHandler = VoiceHandler();
  bool _isReplying = false;
  bool _isListening = false;

  @override
  void initState() {
    _voiceHandler.initSpeech();
    setState(() {});
    super.initState();
  }

  void sendTextMessage(String message) async {
    setReplyMethod(true);
    addToChatList(DateTime.now().toString(), message,
        true); //add chat of user sending data
    addToChatList('typing', 'Typing...', false);
    setInputMode(InputMode.voice);
    final aiResponse = await _aiHandler.getResponse(message);
    removeTypingMethod();
    addToChatList(DateTime.now().toString(), aiResponse,
        false); //add chat of ai giving data
    setReplyMethod(false);
  }

  Future<void> sendVoiceMessage() async {
    if (!_voiceHandler.speechEnabled) {
      const AlertDialog(
        title: Text('Not Supported'),
      );
      debugPrint('unhandled');
      return;
    }
    if (_voiceHandler.speechToText.isListening) {
      await _voiceHandler.stopListening();
      setListenMethod(false);
    } else {
      setListenMethod(true);
      final result = await _voiceHandler.startListening();
      debugPrint(result);

      setListenMethod(false);
      sendTextMessage(result);
    }
  }

  void removeTypingMethod() {
    final chats = ref.read(chatProvider.notifier);
    chats.removeTyping();
  }

  void setReplyMethod(bool isReplying) {
    setState(() {
      _isReplying = isReplying;
    });
  }

  void setListenMethod(bool isListening) {
    setState(() {
      _isListening = isListening;
    });
  }

  void addToChatList(String id, String message, bool isMe) {
    final chats = ref.read(chatProvider.notifier);
    chats.add(ChatModel(id: id, message: message, isMe: isMe));
  }

  void setInputMode(InputMode inputMode) {
    setState(() {
      _inputMode = inputMode;
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    // _aiHandler.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _messageController,
            onChanged: (value) => value.isEmpty
                ? setInputMode(InputMode.voice)
                : setInputMode(InputMode.text),
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
                borderRadius: BorderRadius.circular(
                  12,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        ToggleInputModes(
          isReplying: _isReplying,
          isListening: _isListening,
          inputMode: _inputMode,
          sendTextMessage: () {
            final message = _messageController.text;
            _messageController.clear();
            sendTextMessage(message);
          },
          sendVoiceMessage: sendVoiceMessage,
        ),
      ],
    );
  }
}
