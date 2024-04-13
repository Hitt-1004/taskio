import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_manager/screens/taskDetails.dart';
import '../models/taskModel.dart';
import '../services/tasks.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime(DateTime.now().year - 1),
            lastDay: DateTime(DateTime.now().year + 1),
            onDaySelected: (date, events) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          const SizedBox(height: 20.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'Tasks due on ${DateFormat('yyyy-MM-dd').format(_selectedDate)}:',
              style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10.0),
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, _) {
                List<Task> tasks = taskProvider.tasks.where((task) {
                  return task.deadline.year == _selectedDate.year &&
                      task.deadline.month == _selectedDate.month &&
                      task.deadline.day == _selectedDate.day;
                }).toList();
                if (tasks.isEmpty) {
                  return Center(
                    child: Text('No tasks due on ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
                  );
                }
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.check_box_outlined, color: tasks[index].tag == 'completed' ? Colors.green : Colors.grey),
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
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
