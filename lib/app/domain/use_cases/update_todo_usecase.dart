import 'package:todo_supabase/app/domain/models/todo_model.dart';
import 'package:todo_supabase/app/domain/repository/todo_repository.dart';

class UpdateTodoUsecase {
  final TodoRepository todoRepository;

  UpdateTodoUsecase({required this.todoRepository});

  Future<TodoModel> execute(TodoModel oldTodo, TodoModel newTodo) async {
    return await todoRepository.updateTodo(oldTodo, newTodo);
  }
}
