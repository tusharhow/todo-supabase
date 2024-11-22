import 'package:todo_supabase/app/data/entities/todo_entity.dart';

class TodoModel {
  final int? id;
  final String title;
  final String description;
  final bool isDone;

  TodoModel({
    this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  factory TodoModel.mapTodoEntity(TodoEntity todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isDone: todo.isDone,
    );
  }

  TodoEntity toEntity() {
    return TodoEntity(
      id: id,
      title: title,
      description: description,
      isDone: isDone,
    );
  }

  TodoModel copyWith({
    int? id,
    String? title,
    String? description,
    bool? isDone,
  }) {
    return TodoModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoModel &&
          runtimeType == other.runtimeType &&
          id == other.id;

  @override
  int get hashCode => id.hashCode;
}
