import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/taskModel.dart';
import '../services/tasks.dart';

class EditTaskDetails extends StatefulWidget {
  Task task;
  int func;

  EditTaskDetails({required this.task, required this.func});

  @override
  _EditTaskDetailsState createState() => _EditTaskDetailsState();
}

class _EditTaskDetailsState extends State<EditTaskDetails> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _tagController;
  late TextEditingController _deadlineController;
  late TextEditingController _compsubtaskController;
  late TextEditingController _subtaskController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _tagController = TextEditingController(text: widget.task.tag);
    _compsubtaskController = TextEditingController(text: widget.task.compsubtasks.toString());
    _subtaskController = TextEditingController(text: widget.task.subtasks.toString());
    _deadlineController = TextEditingController(text: DateFormat('yyyy-MM-dd').format(widget.task.deadline));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _tagController.dispose();
    _deadlineController.dispose();
    _subtaskController.dispose();
    _compsubtaskController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: widget.task.deadline,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != widget.task.deadline) {
      setState(() {
        _deadlineController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  void _saveChanges() {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(_deadlineController.text);
    Task updatedTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      tag: _tagController.text,
      subtasks: int.parse(_subtaskController.text),
      compsubtasks: int.parse(_compsubtaskController.text),
      deadline: parsedDate,
    );
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.editTask(widget.task, updatedTask);
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  void _addTask() {
    DateTime parsedDate = DateFormat('dd-MM-yyyy').parse(_deadlineController.text);
    Task newTask = Task(
      title: _titleController.text,
      description: _descriptionController.text,
      tag: _tagController.text,
      subtasks: int.parse(_subtaskController.text),
      compsubtasks: int.parse(_compsubtaskController.text),
      deadline: parsedDate,
    );
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    taskProvider.addTask(newTask);
    Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add or Edit Task', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Title is required'; // Validation error message
                  }
                  return null; // Return null if validation succeeds
                },
                decoration: const InputDecoration(labelText: 'Title *'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _descriptionController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                textInputAction: TextInputAction.newline,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Description is required'; // Validation error message
                  }
                  return null; // Return null if validation succeeds
                },
                decoration: const InputDecoration(labelText: 'Description *'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _tagController,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Tag is required'; // Validation error message
                  }
                  return null; // Return null if validation succeeds
                },
                decoration: const InputDecoration(labelText: 'Tag (Completed/Ongoing/Not Started) *',),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _subtaskController,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Subtasks field is required'; // Validation error message
                  }
                  else if (int.parse(value) == 0) {
                    return 'No. of Subtasks should be greater than 0.';
                  }
                  return null;// Return null if validation succeeds
                },
                decoration: const InputDecoration(labelText: 'Subtasks (>0) *'),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _compsubtaskController,
                validator: (value) {
                  if (value == null || value.isEmpty || value == '') {
                    return 'Completed Subtasks field is required'; // Validation error message
                  }
                    return null;// Return null if validation succeeds
                },
                decoration: const InputDecoration(labelText: 'Completed Subtasks *'),
              ),
              const SizedBox(height: 16.0),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: _deadlineController,
                    readOnly: true,
                    decoration: const InputDecoration(labelText: 'Deadline *'),
                  ),
                ),
              ),
              const SizedBox(height: 32.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(const Color(0xFF6146C6))
                    ),
                    onPressed: widget.func == 0 ? _addTask : _saveChanges,
                    child: const Text('Save Details', style: TextStyle(color: Colors.white),),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
