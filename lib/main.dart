import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:todo_task/screens/home_screen.dart';
import 'package:todo_task/screens/splash_screen.dart';
import 'package:todo_task/services/todo_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ToDoProvider todoProvider = ToDoProvider();
  await todoProvider.loadTodos();
  runApp(MyApp(todoProvider: todoProvider));
}

class MyApp extends StatelessWidget {

  final ToDoProvider todoProvider;

  const MyApp({super.key, required this.todoProvider});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: todoProvider,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter ToDo App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:const SplashScreen(),
      ),
    );
  }
}
