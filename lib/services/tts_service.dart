import 'package:flutter_tts/flutter_tts.dart';

class TTSService {
  late FlutterTts flutterTts;

  TTSService() {
    flutterTts = FlutterTts();
  }

  Future<void> speak(String text) async {
    await flutterTts.speak(text);
  }
}
