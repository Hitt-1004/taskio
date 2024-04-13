class Task {
  final String title;
  final String description;
  final String tag;
  final int subtasks;
  final int compsubtasks;
  late final DateTime deadline;

  Task({
    required this.title,
    required this.description,
    required this.tag,
    required this.subtasks,
    required this.compsubtasks,
    required this.deadline,
  });

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      title: map['title'],
      description: map['description'],
      tag: map['tag'],
      subtasks: map['subtasks'],
      compsubtasks: map['compsubtasks'],
      deadline: DateTime.parse(map['deadline']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'tag': tag,
      'subtasks': subtasks,
      'compsubtasks': compsubtasks,
      'deadline': deadline.toIso8601String(),
    };
  }
}
