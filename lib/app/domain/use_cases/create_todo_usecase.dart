import 'package:todo_supabase/app/domain/models/todo_model.dart';
import 'package:todo_supabase/app/domain/repository/todo_repository.dart';

class CreateTodoUsecase {
  final TodoRepository todoRepository;

  CreateTodoUsecase({required this.todoRepository});

  Future<TodoModel> execute(TodoModel todo) async {
    return await todoRepository.createTodo(todo);
  }
}
