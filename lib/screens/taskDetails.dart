import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:task_manager/models/taskModel.dart';
import 'package:task_manager/screens/editTask.dart';

import '../services/tasks.dart';

class taskDetails extends StatefulWidget {
  taskDetails({super.key, required this.task});

  Task task;

  @override
  State<taskDetails> createState() => _taskDetailsState(task);
}

class _taskDetailsState extends State<taskDetails> {
  _taskDetailsState(this.task);

  Task task;

  @override
  Widget build(BuildContext context) {
    TaskProvider taskProvider = Provider.of<TaskProvider>(context, listen: false);
    double percentage = (task.compsubtasks / task.subtasks) * 100;

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.65,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFCE93),
                    borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), // Adjust the shadow color and opacity as needed
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(child: Text(task.tag)), // Add your child widget here
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(onPressed: (){
                      taskProvider.removeTask(task).then((value) => {
                        if(value == true) Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false)
                      });

                      }, icon: const Icon(Icons.delete_outline_rounded)),
                    const SizedBox(width: 8,),
                    IconButton(onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => EditTaskDetails(task: task, func: 1,)));
                      }, icon: const Icon(Icons.edit_note_outlined))
                  ],
                )
              ],
            ),
            const SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40, // Adjust the width as needed
                  height: 40, // Adjust the height as needed
                  child: CustomPaint(
                    painter: CircleProgressPainter(percentage/100),
                    child: Center(
                      child: Text(
                        '${percentage.toInt()}%',
                        style: const TextStyle(
                          fontSize: 12, // Adjust the font size as needed
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 25,),
                Text(task.title, style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),),
              ],
            ),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 140,
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.1), // Adjust the shadow color and opacity as needed
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: const Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Center(child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Icon(Icons.calendar_month, size: 20,),
                      const SizedBox(width: 8,),
                      Text(DateFormat('MMMM d, yyyy').format(task.deadline), style: const TextStyle(fontSize: 10),),
                    ],
                  ), // Add your child widget here
                  ),),
              ],
            ),
            const SizedBox(height: 30,),
            Text(task.description),
            const SizedBox(height: 8,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.green)
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Icon(Icons.check_box, color: Colors.green,),
                      Text('${task.compsubtasks} Tasks', style: TextStyle(color: Colors.grey[700]),)
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class CircleProgressPainter extends CustomPainter {
  final double percentage;

  CircleProgressPainter(this.percentage);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint completedPaint = Paint()
      ..color = Colors.green // Completed percentage color
      ..strokeWidth = 5 // Adjust the stroke width as needed
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final Paint remainingPaint = Paint()
      ..color = Colors.grey.withOpacity(0.5) // Light grey for remaining percentage
      ..strokeWidth = 5 // Adjust the stroke width as needed
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final double radius = size.width / 2;
    final Offset center = Offset(size.width / 2, size.height / 2);

    const double startAngle = -pi / 2;
    final double completedSweepAngle = 2 * pi * percentage;
    final double remainingSweepAngle = 2 * pi * (1 - percentage);

    // Draw completed portion
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      completedSweepAngle,
      false,
      completedPaint,
    );

    // Draw remaining portion
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle + completedSweepAngle,
      remainingSweepAngle,
      false,
      remainingPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}