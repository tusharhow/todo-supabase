import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:todo_supabase/app/views/todo_screen.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://lcngwscnqyyusvrszcyj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxjbmd3c2NucXl5dXN2cnN6Y3lqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIyNzc0MTcsImV4cCI6MjA0Nzg1MzQxN30.gY2er0alItX5cEmrAA1e9qGDKlUGO-MH5IparDCuoPQ',
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 18, 11, 49),
        ),
        useMaterial3: true,
      ),
      home: const TodoScreen(),
    );
  }
}
