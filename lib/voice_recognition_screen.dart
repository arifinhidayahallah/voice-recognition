import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class VoiceRecognitionScreen extends StatefulWidget {
  const VoiceRecognitionScreen({super.key});

  @override
  VoiceRecognitionScreenState createState() => VoiceRecognitionScreenState();
}

class VoiceRecognitionScreenState extends State<VoiceRecognitionScreen> {
  static const platform = MethodChannel('com.example.speech/recognition');
  String _spokenText = "🎤 Tekan mic & mulai ngomong...";
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    platform.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'onSpeechResult':
        setState(() {
          _spokenText = "✅ Final: ${call.arguments}";
          _isListening = false;
        });
        break;
      case 'onSpeechPartialResult':
        setState(() {
          _spokenText = "🔴 Live: ${call.arguments}";
        });
        break;
      case 'onSpeechError':
        setState(() {
          _spokenText = "❌ Error: ${call.arguments}";
          _isListening = false;
        });
        break;
    }
  }

  Future<void> _toggleListening() async {
    try {
      final String result = await platform.invokeMethod(
        _isListening ? 'stopListening' : 'startListening',
      );

      setState(() {
        _isListening = !_isListening;
        if (!_isListening) _spokenText = "Rekam suara ...";
      });
    } on PlatformException catch (e) {
      setState(() {
        _spokenText = "Gagal: '${e.message}'";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voice Recognition Flutter"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                _isListening ? Icons.mic : Icons.mic_off,
                size: 80,
                color: _isListening ? Colors.green : Colors.red,
              ),
              SizedBox(height: 20),
              Text(
                _spokenText,
                style: TextStyle(fontSize: 24, color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleListening,
        child: Icon(_isListening ? Icons.stop : Icons.mic, size: 30),
      ),
    );
  }
}
