import 'package:flutter/material.dart';
import 'package:todo_supabase/app/domain/models/todo_model.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.todo,
    required this.onDone,
    required this.onDelete,
    required this.onUpdate,
  });

  final TodoModel todo;
  final Function(TodoModel) onDone;
  final Function(TodoModel) onDelete;
  final Function(TodoModel, TodoModel) onUpdate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showEditDialog(context),
      child: Card(
        elevation: 0,
        color: todo.isDone ? Colors.white.withOpacity(0.05) : Colors.white10,
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: ListTile(
          leading: Checkbox(
            value: todo.isDone,
            onChanged: (_) => onDone(todo),
            activeColor: Colors.white,
            checkColor: Colors.blueGrey[900],
          ),
          title: Text(
            todo.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            todo.description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.white38,
              decoration: todo.isDone ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete, color: Colors.white30),
            onPressed: () => _showDeleteConfirmation(context),
          ),
        ),
      ),
    );
  }

  Future<void> _showEditDialog(BuildContext context) async {
    final titleController = TextEditingController(text: todo.title);
    final descriptionController = TextEditingController(text: todo.description);

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Todo'),
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
            onPressed: () {
              if (titleController.text.isNotEmpty) {
                final updatedTodo = todo.copyWith(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                onUpdate(todo, updatedTodo);
                Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _showDeleteConfirmation(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Todo'),
        content: const Text('Are you sure you want to delete this todo?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onDelete(todo);
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
