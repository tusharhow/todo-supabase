import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/app/core/constants/api_constants.dart';
import 'package:todo_supabase/app/data/entities/todo_entity.dart';

class SupabaseService {
  final SupabaseClient supabase;

  SupabaseService({required this.supabase});

  Future<List<TodoEntity>> fetchTodos() async {
    final response = await supabase.from(ApiConstants.tableName).select();
    return response.map((e) => TodoEntity.fromJson(e)).toList();
  }

  Future<TodoEntity> createTodo(TodoEntity todo) async {
    final response =
        await supabase.from(ApiConstants.tableName).insert(todo.toJson()).select();
    return TodoEntity.fromJson(response.first);
  }

  Future<TodoEntity> updateTodo(TodoEntity oldTodo, TodoEntity newTodo) async {
    final response = await supabase
        .from(ApiConstants.tableName)
        .update(newTodo.toJson())
        .eq("id", oldTodo.id!)
        .select();
    return TodoEntity.fromJson(response.first);
  }

  Future<void> deleteTodo(int id) async {
    await supabase.from(ApiConstants.tableName).delete().eq("id", id);
  }
}
