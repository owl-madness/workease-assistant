import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'emotion_service.dart';

class EmotionProvider with ChangeNotifier {
  final EmotionService _emotionService = EmotionService();

  bool _modelLoaded = false;

  String _currentMood = "None";
  String get currentMood => _currentMood;

  Future<void> initializeModel() async {
    if (!_modelLoaded) {
      await _emotionService.loadModel();
      _modelLoaded = true;
    }
  }

  Future<void> analyzeImage(Uint8List imageBytes) async {
    final result = await _emotionService.runModel(imageBytes);

    final emotion = _mapOutputToEmotion(result);
    print("current captured emotion:: $emotion");
    _currentMood = emotion;
    notifyListeners();
  }

  String _mapOutputToEmotion(List<double> output) {
    final emotions = [
      "Angry",
      "Disgust",
      "Fear",
      "Happy",
      "Sad",
      "Surprise",
      "Neutral"
    ];

    int maxIndex = 0;
    double maxValue = output[0];

    for (int i = 1; i < output.length; i++) {
      if (output[i] > maxValue) {
        maxValue = output[i];
        maxIndex = i;
      }
    }

    return emotions[maxIndex];
  }

  String get advice {
    switch (_currentMood) {
      case "Happy":
        return "Great energy. Focus on your top task.";
      case "Sad":
        return "Take small steps. Start light.";
      case "Angry":
        return "Pause. Breathe. Then act.";
      case "Fear":
        return "You're overthinking. Start anyway.";
      case "Surprise":
        return "Something unexpected? Adapt and move.";
      case "Neutral":
        return "Steady mode. Let's be productive.";
      case "Disgust":
        return "Step away briefly and reset.";
      default:
        return "Tap to analyze mood.";
    }
  }
}
