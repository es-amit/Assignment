class Todo{
  String id;
  String title;
  bool isCompleted;
  DateTime? reminder;

  Todo({
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.reminder
  });
}