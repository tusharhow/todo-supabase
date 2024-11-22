import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_supabase/app/core/di/providers.dart';
import 'package:todo_supabase/app/domain/models/todo_model.dart';

part 'todo_provider.g.dart';

@riverpod
class Todos extends _$Todos {
  @override
  Future<List<TodoModel>> build() async {
    final getTodosUsecase = ref.watch(getTodosUsecaseProvider);
    return await getTodosUsecase.execute();
  }

  Future<void> createTodo(TodoModel todo) async {
    final createTodoUsecase = ref.watch(createTodoUsecaseProvider);
    final createdTodo = await createTodoUsecase.execute(todo);
    state = AsyncValue.data([...state.value ?? [], createdTodo]);
  }

  Future<void> updateTodo(TodoModel oldTodo, TodoModel newTodo) async {
    try {
      final updateTodoUsecase = ref.watch(updateTodoUsecaseProvider);
      final updatedTodo = await updateTodoUsecase.execute(oldTodo, newTodo);
      
      state = AsyncValue.data(
        (state.value ?? []).map((todo) {
          if (todo.id == oldTodo.id) return updatedTodo;
          return todo;
        }).toList(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTodo(int id) async {
    final deleteTodoUsecase = ref.watch(deleteTodoUsecaseProvider);
    await deleteTodoUsecase.execute(id);
    state = AsyncValue.data(
      (state.value ?? []).where((t) => t.id != id).toList(),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      return await ref.watch(getTodosUsecaseProvider).execute();
    });
  }
}
