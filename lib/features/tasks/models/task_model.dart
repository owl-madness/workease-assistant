class Task {
  final String id;
  final String title;
  bool isCompleted;
  // String? linkedEmotion; // Optional: Link a task to the emotion felt when created

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    // this.linkedEmotion,
  });
}