import 'package:flutter/material.dart';

class EmotionProvider with ChangeNotifier {
  String _currentMood = "None";
  String get currentMood => _currentMood;

  void updateMood(String newMood) {
    _currentMood = newMood;
    notifyListeners();
  }

  String get advice {
    switch (_currentMood) {
      case "Happy": return "Great energy! Let's crush your top task.";
      case "Stressed": return "Deep breaths. Maybe start with something easy?";
      case "Sad": return "It's okay to take it slow today. I'm here to help.";
      default: return "Tap the button to start the check.";
    }
  }
}