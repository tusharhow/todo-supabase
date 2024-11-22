import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_supabase/app/domain/models/todo_model.dart';
import 'package:todo_supabase/app/views/components/todo_item.dart';
import 'package:todo_supabase/app/views/providers/todo_provider.dart';

class TodoScreen extends ConsumerWidget {
  const TodoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 18, 11, 49),
      appBar: AppBar(
        title: const Text('Todo', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color.fromARGB(255, 18, 11, 49),
      ),
      body: todos.when(
        data: (todoList) => ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            final todo = todoList[index];
            return TodoItem(
              todo: todo,
              onDone: (todo) => ref.read(todosProvider.notifier).updateTodo(
                    todo,
                    todo.copyWith(isDone: !todo.isDone),
                  ),
              onDelete: (todo) =>
                  ref.read(todosProvider.notifier).deleteTodo(todo.id!),
              onUpdate: (oldTodo, newTodo) =>
                  ref.read(todosProvider.notifier).updateTodo(
                        oldTodo,
                        newTodo,
                      ),
            );
          },
        ),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTodoDialog(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> showAddTodoDialog(BuildContext context, WidgetRef ref) async {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add Todo'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                filled: true,
                fillColor: Colors.grey[200],
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Description',
                filled: true,
                fillColor: Colors.grey[200],
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                await ref.read(todosProvider.notifier).createTodo(
                      TodoModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        isDone: false,
                      ),
                    );
                if (context.mounted) {
                  Navigator.pop(context);
                }
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}
