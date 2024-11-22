import 'package:todo_supabase/app/domain/models/todo_model.dart';
import 'package:todo_supabase/app/domain/repository/todo_repository.dart';

class GetTodosUsecase {
  final TodoRepository todoRepository;

  GetTodosUsecase({required this.todoRepository});

  Future<List<TodoModel>> execute() async {
    return await todoRepository.fetchTodos();
  }
}
