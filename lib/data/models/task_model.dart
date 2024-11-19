class TaskModel {
  int? id;
  final String title;
  final String description;
  bool isCompleted;
  DateTime? deadLine;
  DateTime? createdAt;

  TaskModel({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    this.deadLine,
    this.createdAt,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
      deadLine: json['deadLine'] != null ? DateTime.parse(json['deadLine']) : null,
      createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'deadLine': deadLine?.toIso8601String(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }
}
