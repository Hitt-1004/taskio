import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/screens/editTask.dart';
import 'package:task_manager/screens/taskDetails.dart';

import '../models/taskModel.dart';
import '../services/tasks.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String date = DateFormat('MMMM d, yyyy').format(DateTime.now().toLocal());
  String selectedValue = 'All Tasks';
  List<Task> tasks = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.loadTasks().then((value) {
      setState(() {
        tasks = taskProvider.tasks;
        isLoading = false;
      });
    }).catchError((error) {
      // Handle error loading tasks
      print("Error loading tasks: $error");
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    // taskProvider.loadTasks().then((value) => isLoading = false);
    // tasks = taskProvider.tasks;

    // Method to add a new task
    void _addTask() {
      // tasks.add(Task(
      //   title: 'title1',
      //   description: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
      //   deadline: DateTime.now(),
      //   subtasks: 10,
      //   compsubtasks: 1, tag: 'Ongoing'
      // ));
      //popup box containing form to add task
      Navigator.push(context, MaterialPageRoute(builder: (context) => EditTaskDetails(task: Task(title: '', deadline: DateTime.now(), description: '', tag: '', subtasks: 0, compsubtasks: 0), func: 0)));
      print('Add Task functionality activated');
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(color: Colors.black, fontSize: 18),),
                const SizedBox(width: 8,),
                IconButton(onPressed:() {
                  Navigator.pushNamed(context, '/calendar');
                },
                    icon: const Icon(Icons.calendar_month)
                )
              ],
            ),
            IconButton(onPressed: () => Navigator.pushNamed(context, '/profile'),
                icon: const Icon(Icons.person_outline))
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: _addTask,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Add Task', style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18
                      ),),
                      const SizedBox(width: 8,),
                      Container(
                        width: 22,
                        height: 22,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFFFCE93)
                        ),
                        child: const Center(
                          child: Text('+', style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16
                          ),),
                        ),
                      )
                    ],
                  ),
                ),
                DropdownButton<String>(
                  value: selectedValue,
                  icon: const Icon(Icons.expand_circle_down_outlined),
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() {
                        selectedValue = newValue; // Update the selected value when the dropdown value changes
                      });
                    }
                  },
                  items: <String>['All Tasks', 'Ongoing', 'Completed', 'Not Started'] // List of dropdown items
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ],
            ),
            const SizedBox(height: 15,),
            Expanded(
                child: tasks.isEmpty
                    ? !isLoading
                      ? const Text("No Tasks Added. \nClick on 'Add Task' to Start Adding Tasks.")
                      : const Center(child: CircularProgressIndicator(color: Color(0xFF6146C6),))
                    : ListView.builder(
                      itemCount: selectedValue == 'All Tasks' ? tasks.length : tasks.where((task) => task.tag == selectedValue).length,
                      itemBuilder: (context, index) {
                      if(selectedValue != 'All Tasks') tasks = tasks.where((task) => task.tag == selectedValue).toList();
                      return Card(
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.check_box_outlined, color: tasks[index].tag == 'Completed' ? Colors.green : Colors.grey),
                            ),
                            Expanded(
                              child: ListTile(
                                title: Text(tasks[index].title),
                                subtitle: Text(DateFormat('MMMM d, yyyy').format(tasks[index].deadline)),
                                onTap: () {
                                  showModalBottomSheet(context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                    return taskDetails(task: tasks[index]);
                                      });
                                },
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Icon(Icons.chevron_right),
                            )
                          ],
                        ),
                      );
                    })
            )
          ],
        ),
      ),
    );
  }
}