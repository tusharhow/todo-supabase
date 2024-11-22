import 'package:todo_supabase/app/domain/models/todo_model.dart';

abstract class TodoRepository {
  Future<List<TodoModel>> fetchTodos();
  Future<TodoModel> createTodo(TodoModel todo);
  Future<TodoModel> updateTodo(TodoModel oldTodo, TodoModel newTodo);
  Future<void> deleteTodo(int id);
}
