import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

const OPENAI_API_KEY = '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'; //quota left api
// ignore: constant_identifier_names
// const OPENAI_API_KEY = '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';

class OpenAIService {
  final List<Map<String, String>> messages = [];
  Future<String> getResponse(String message) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $OPENAI_API_KEY",
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": message}
          ],
        }),
      );
      messages.add({
        'role': 'user',
        'content': message,
      });
      debugPrint(res.body);
      final response = json.decode(res.body);
      if (res.statusCode == 200) {
        final String content = response['choices'][0]['message']['content'];
        messages.add({
          'role': 'assistant',
          'content': content.trim(),
        });
        return content.trim();
      }
      return response['error']['message'].toString().trim();
    } catch (err) {
      return err.toString();
    }
  }
}



// {"id":"chatcmpl-7KOkYrH7E0GEKouJ5E09KxQdcPypc","object":"chat.completion","created":1685096054,"model":"gpt-3.5-turbo-0301","usage":{"prompt_tokens":11,"completion_tokens":137,"total_tokens":148},"choices":[{"message":{"role":"assistant","content":"Flutter is an open-source UI software development kit (SDK) developed by Google. It is used to build high-performance, high-fidelity, apps for multiple platforms including iOS, Android, web, desktop, and embedded devices using a single codebase. Flutter has a modern architecture that uses a reactive programming model and a strong focus on widget-based design to help developers build beautiful and responsive user interfaces. It also has a rich set of pre-built widgets and tools that simplify the app development process, making it easier and faster to create cross-platform apps. It uses Dart programming language which is easy to learn and helps in writing efficient code and eliminates the need for separate development cycles for different platforms."},