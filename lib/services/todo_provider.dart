import 'package:flutter/material.dart';
import 'package:todo_task/database/database.dart';
import 'package:todo_task/model/todo_model.dart';

class ToDoProvider with ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;
  
  int getCompletedTaskCount() {
    return _todos.where((todo) => todo.isCompleted).length;
  }

  Future loadTodos() async {
    _todos = await DatabaseHelper.instance.getTodos();
    notifyListeners();
  }

  void addTodo(Todo todo) async {
    await DatabaseHelper.instance.addTodo(todo);
    await loadTodos();
  }

  void updateTodo(Todo todo) async {
    await DatabaseHelper.instance.updateTodo(todo);
    await loadTodos();
  }

  void deleteTodo(int id) async {
    await DatabaseHelper.instance.deleteTodo(id);
    await loadTodos();
  }
}
