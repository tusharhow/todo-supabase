import 'package:todo_supabase/app/domain/repository/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository todoRepository;

  DeleteTodoUsecase({required this.todoRepository});

  Future<void> execute(int id) async {
    await todoRepository.deleteTodo(id);
  }
}
