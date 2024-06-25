import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class Textspeech {
  final FlutterTts tts = FlutterTts();
  TextSpeech(String text) {
    tts.setLanguage("en-US");
    tts.setSpeechRate(0.4);
    tts.speak(text);
  }
}
