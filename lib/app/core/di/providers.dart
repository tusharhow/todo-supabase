import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/app/data/remote/supabase_service.dart';
import 'package:todo_supabase/app/data/repository/todo_repo_impl.dart';
import 'package:todo_supabase/app/domain/repository/todo_repository.dart';
import 'package:todo_supabase/app/domain/use_cases/create_todo_usecase.dart';
import 'package:todo_supabase/app/domain/use_cases/delete_todo_usecase.dart';
import 'package:todo_supabase/app/domain/use_cases/get_todos_usecase.dart';
import 'package:todo_supabase/app/domain/use_cases/update_todo_usecase.dart';

part 'providers.g.dart';


@riverpod
SupabaseClient supabaseClientProvider(Ref ref) {
  return Supabase.instance.client;
}

@riverpod
SupabaseService supabaseServiceProvider(Ref ref) {
  return SupabaseService(supabase: ref.watch(supabaseClientProviderProvider));
}

@riverpod
GetTodosUsecase getTodosUsecase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return GetTodosUsecase(todoRepository: repository);
}

@riverpod
CreateTodoUsecase createTodoUsecase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return CreateTodoUsecase(todoRepository: repository);
}

@riverpod
UpdateTodoUsecase updateTodoUsecase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return UpdateTodoUsecase(todoRepository: repository);
}

@riverpod
DeleteTodoUsecase deleteTodoUsecase(Ref ref) {
  final repository = ref.watch(todoRepositoryProvider);
  return DeleteTodoUsecase(todoRepository: repository);
}

@riverpod
TodoRepository todoRepository(Ref ref) {
  return TodoRepoImpl(
    supabaseService: ref.watch(supabaseServiceProviderProvider),
  );
}
