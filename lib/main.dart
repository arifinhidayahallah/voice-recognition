import 'package:flutter/material.dart';
import 'package:speech_to_text_recognition/voice_recognition_screen.dart';

void main() => runApp(VoiceMasterApp());

class VoiceMasterApp extends StatelessWidget {
  const VoiceMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurpleAccent,
        ),
      ),
      home: VoiceRecognitionScreen(),
    );
  }
}
