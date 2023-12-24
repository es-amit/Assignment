
class Todo {
  int? id;
  String title;
  bool isCompleted;
  DateTime? reminder;

  Todo({
    this.id, 
    required this.title, 
    this.isCompleted = false, 
    this.reminder
  });

  Todo copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? reminder,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      reminder: reminder ?? this.reminder,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'isCompleted': isCompleted ? 1 : 0,
      'reminder': reminder?.millisecondsSinceEpoch,
    };
  }

  static Todo fromMap(Map<String, dynamic> map) {
    return Todo(
      id: map['id'],
      title: map['title'],
      isCompleted: map['isCompleted'] == 1,
      reminder: map['reminder'] != null ? DateTime.fromMillisecondsSinceEpoch(map['reminder']) : null,
    );
  }
}