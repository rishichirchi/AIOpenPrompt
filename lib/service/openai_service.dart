import 'dart:convert';

import 'package:ai_app/constants/api.dart';
import 'package:http/http.dart' as http;

class OpenAIService {
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final response = await http.post(
        Uri.parse('https://api.openai.com/v1/chat/completions'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $openAIAPIKey',
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "system", "content": "You are a helpful assistant."},
            {
              "role": "user",
              "content":
                  "Does this message want to generate an AI image, art or anything similiar? $prompt . Simply  answer with a yes or a no!"
            },
          ]
        }),
      );
      print(response.body);

      if (response.statusCode == 200) {
        print('lets gooo!');
      }
    } catch (e) {
      e.toString();
    }
    return 'yay';
  }

  Future<String> chatGPTAPI() async {
    return 'chat gpt';
  }

  Future<String> dallEAPI() async {
    return 'dall-E';
  }
}
