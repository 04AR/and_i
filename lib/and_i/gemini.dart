import 'dart:io';
import 'package:google_generative_ai/google_generative_ai.dart';

class Gemini {
  var _model;

  Gemini(String apiKey) {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<String> response(String promt) async {
    final content = [Content.text(promt)];
    final response = await _model.generateContent(content);
    print("\n");
    print("\n");
    print(response.text);
    print("\n");
    print("\n");
    return response.text;
  }
}
