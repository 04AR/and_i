import 'package:google_generative_ai/google_generative_ai.dart';

class Gemini {
  var model;

  Gemini(String apiKey) {
    model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
        systemInstruction: Content.system(
            'You name is andi. Meaning android intelligence. You are AI that is emmbeded in smartphone which then can serve as a robot when connected through to your body.'));
  }

  Future<String> promt(String promt) async {
    final content = [Content.text(promt)];
    final response = await model.generateContent(content);
    return response.text;
  }


}
