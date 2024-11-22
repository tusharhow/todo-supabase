import 'package:todo_supabase/app/data/remote/supabase_service.dart';
import 'package:todo_supabase/app/domain/models/todo_model.dart';
import 'package:todo_supabase/app/domain/repository/todo_repository.dart';

class TodoRepoImpl implements TodoRepository {
  final SupabaseService supabaseService;

  TodoRepoImpl({required this.supabaseService});

  @override
  Future<List<TodoModel>> fetchTodos() async {
    final todos = await supabaseService.fetchTodos();
    return todos.map((e) => TodoModel.mapTodoEntity(e)).toList();
  }

  @override
  Future<TodoModel> createTodo(TodoModel todo) async {
    final todoEntity = await supabaseService.createTodo(todo.toEntity());
    return TodoModel.mapTodoEntity(todoEntity);
  }

  @override
  Future<TodoModel> updateTodo(TodoModel oldTodo, TodoModel newTodo) async {
    final todoEntity = await supabaseService.updateTodo(
        oldTodo.toEntity(), newTodo.toEntity());
    return TodoModel.mapTodoEntity(todoEntity);
  }

  @override
  Future<void> deleteTodo(int id) async {
    await supabaseService.deleteTodo(id);
  }
}
