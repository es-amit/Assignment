import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo_task/model/todo_model.dart';
import 'package:todo_task/services/todo_provider.dart';

class NewTodo extends StatefulWidget {
  const NewTodo({super.key});

  @override
  State<NewTodo> createState() => _NewTodoState();
}

class _NewTodoState extends State<NewTodo> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController controller;
  DateTime? selectedDate;
  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Todo"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: Column(
              children: [
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: "Title",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.grey, width: 1)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide:
                            const BorderSide(color: Colors.blue, width: 1)),
                  ),
                  
                ),
                const SizedBox(height: 30,),
                Row(
                  children: [
                    IconButton(
                      onPressed: () async{
                        selectedDate = await pickDateTime(context,DateTime.now() );
                        setState(() {
                          
                        });
                      }, 
                      icon: const Icon(Icons.calendar_month,
                        size: 30,)
                    ),
                    Text(selectedDate == null
                        ? "No reminder Selected"
                        : formatDateTime(selectedDate!),
                      style: const TextStyle(
                        fontSize: 20
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    _saveForm(context);
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width * 0.7,
                    decoration: BoxDecoration(
                      
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey
                    ),
                    child: const Center(
                      child: Text("Add New Task",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),)
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void _saveForm(BuildContext context) {
    final form = _formKey.currentState;
    if (form != null && form.validate() && controller.text.isNotEmpty) {
      form.save();
      final newTodo = Todo(
          title: controller.text, isCompleted: false, reminder: DateTime.now());
      Provider.of<ToDoProvider>(context, listen: false).addTodo(newTodo);
      Navigator.of(context).pop(true);
    }
    else{
      showDialog(
        context: context, 
        builder: (context){
          return const AlertDialog(
            icon: Icon(Icons.close_outlined,
              color: Colors.red,),
            content: Text("Title Field is empty",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                
              ),),
          );
        }
      );
    }
  }
  Future<DateTime?> pickDateTime(BuildContext context, DateTime initialDate) async {
  // First, let the user pick a date
  final date = await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
  if (date == null) return null; // User canceled the picker

  // Then, let them pick a time
  // ignore: use_build_context_synchronously
  final time = await showTimePicker(
    context: context,
    initialTime: TimeOfDay.fromDateTime(initialDate),
  );
  if (time == null) return null; // User canceled the picker

  // Combine the date and time into a single DateTime
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}


  String formatDateTime(DateTime dateTime){
    DateFormat formmatter = DateFormat('dd/MM/yyyy HH:mm a');
    String date = formmatter.format(dateTime);
    return date;
  }
}
