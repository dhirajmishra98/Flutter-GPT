import 'package:flutter/material.dart';
import 'package:gpt_chat/widgets/text_and_voice_field.dart';

class ToggleInputModes extends StatefulWidget {
  final InputMode inputMode;
  final VoidCallback sendTextMessage;
  final VoidCallback sendVoiceMessage;
  final bool isReplying;
  final bool isListening;

  const ToggleInputModes({
    super.key,
    required this.inputMode,
    required this.sendTextMessage,
    required this.sendVoiceMessage,
    required this.isReplying,
    required this.isListening,
  });

  @override
  State<ToggleInputModes> createState() => _ToggleInputModesState();
}

class _ToggleInputModesState extends State<ToggleInputModes> {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10)),
      onPressed: widget.isReplying == true
          ? null
          : widget.inputMode == InputMode.text
              ? widget.sendTextMessage
              : widget.sendVoiceMessage,
      child: Icon(widget.inputMode == InputMode.voice
          ? widget.isListening == true
              ? Icons.mic_off
              : Icons.mic
          : Icons.send),
    );
  }
}
