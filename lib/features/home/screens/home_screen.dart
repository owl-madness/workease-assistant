import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../emotion/providers/emotion_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<EmotionProvider>(context, listen: false).initializeModel());
  }

  @override
  Widget build(BuildContext context) {
    // Watch the emotion provider to update the UI when state changes
    final emotionProvider = context.watch<EmotionProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("WorkEase Hub"),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.list_alt),
            onPressed: () => Navigator.pushNamed(context, '/tasks'),
          )
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Emotion Display Area
              _buildEmotionDisplay(emotionProvider.currentMood),

              const SizedBox(height: 40),

              // 2. Assistant Advice (Only shows if emotion isn't 'None')
              if (emotionProvider.currentMood != "None")
                _buildAssistantCard(emotionProvider.advice),

              const SizedBox(height: 60),

              // 3. The Main Action Button
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                onPressed: () async {
                  // Mocking the detection for now
                  // emotionProvider.updateMood("Happy");

                  final bytes =
                      await rootBundle.load('assets/images/test_face.png');

                  Provider.of<EmotionProvider>(context, listen: false)
                      .analyzeImage(bytes.buffer.asUint8List());
                },
                icon: const Icon(Icons.camera_alt),
                label: const Text("Capture My Emotion",
                    style: TextStyle(fontSize: 18)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmotionDisplay(String mood) {
    return Column(
      children: [
        Text(
          mood == "None" ? "How are you feeling?" : "You look...",
          style: const TextStyle(fontSize: 20, color: Colors.grey),
        ),
        Text(
          mood == "None" ? "---" : mood,
          style: const TextStyle(
              fontSize: 48, fontWeight: FontWeight.bold, color: Colors.indigo),
        ),
      ],
    );
  }

  Widget _buildAssistantCard(String advice) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.indigo.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.indigo.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          const Icon(Icons.auto_awesome, color: Colors.indigo),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              advice,
              style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
