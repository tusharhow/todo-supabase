class TodoEntity {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  TodoEntity({this.id, required this.title, required this.description, this.isDone = false});

  factory TodoEntity.fromJson(Map<String, dynamic> json) {
    return TodoEntity(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isDone: json['isDone'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
    };
  }
}
