import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/screens/new_todo_screen.dart';
import 'package:todo_task/services/todo_provider.dart';
import 'package:todo_task/widgets/button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          elevation: 6,
          centerTitle: true,
          foregroundColor: Colors.white,
          title: const Text("Todo list"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("${Provider.of<ToDoProvider>(context).getCompletedTaskCount().toString()} out of ${Provider.of<ToDoProvider>(context).todos.length} are completed!!",
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Consumer<ToDoProvider>(
                  builder: (context, provider, child) {
                    return ListView.builder(
                        itemCount: provider.todos.length,
                        itemBuilder: ((context, index) {
                          final todo = provider.todos[index];
                          return ListTile(
                            leading: Checkbox(
                                value: todo.isCompleted,
                                onChanged: (value) {
                                  _toggleTodoStatus(provider, todo);
                                  // ignore: unnecessary_null_comparison
                                  if (!todo.isCompleted) {
                                    showSnackbar("Yay!! Task Completed", context);
                                  }
                                }),
                            title: Text(
                              todo.title,
                              style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 1.3),
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  provider.deleteTodo(todo.id!);
                                },
                                icon: const Icon(Icons.delete)),
                          );
                        }));
                  },
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomButton(onTap: () async {
            bool result = await Navigator.push(context,
                MaterialPageRoute(builder: ((context) => const NewTodo())));
            try {
              // Check if result is not null and true
              if (result) {
                // ignore: use_build_context_synchronously
                showSnackbar("Task Added!", context);
              }
            } catch (e) {
              print(e.toString());
            }
          }),
        ));
  }

  void showSnackbar(String msg, BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(milliseconds: 2000),
    ));
  }

  void _toggleTodoStatus(ToDoProvider provider, Todo todo) {
    // Update the ToDo status
    provider.updateTodo(todo.copyWith(isCompleted: !todo.isCompleted));
  }
}
