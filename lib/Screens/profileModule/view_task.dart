// ViewTask.dart

import 'package:flutter/material.dart';
import 'package:task_management/Data/Components/expanded_view_task.dart';
import 'package:task_management/Data/Constants/colors.dart';
import 'package:task_management/Data/Constants/routes.dart';
import 'package:task_management/Screens/profileModule/add_task.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({super.key});

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  List<Map<String, String>> tasks = [
    {
      'title': 'Demo Task',
      'desc':
          'You cannot edit this task, this task is here just to populate the UI. To add a task, click on the Add Task button, after adding the task, click on the edit button to edit it and swipe left to delte a task.',
      'priority': 'High',
      'status': 'Open',
      'user': 'User 1',
      'date': '2024-07-28'
    },
  ];

  Future<void> _navigateToAddTask(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTask(),
      ),
    );

    if (result != null) {
      final newTask = Map<String, String>.from(result['task']);
      final index = result['index'] as int?;
      setState(() {
        if (index != null) {
          tasks[index] = newTask;
        } else {
          tasks.add(Map<String, String>.from(newTask));
        }
      });
    }
  }

  Future<void> _navigateToEditTask(BuildContext context, int index) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddTask(task: tasks[index], index: index),
      ),
    );

    if (result != null) {
      final updatedTask = Map<String, String>.from(result['task']);
      final updatedIndex = result['index'] as int?;
      setState(() {
        if (updatedIndex != null) {
          tasks[updatedIndex] = updatedTask;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        title: Text(
          'View Task',
          style: TextStyle(color: white),
        ),
        leading: IconButton(
          onPressed: () {
            Future.microtask(() {
              RoutingService.goBack(context);
            });
          },
          icon: Icon(
            Icons.arrow_back,
            color: white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Dismissible(
                      key: Key(tasks[index]['title']!),
                      direction: DismissDirection.endToStart,
                      onDismissed: (direction) {
                        final String deletedTaskTitle = tasks[index]['title']!;
                        setState(() {
                          tasks.removeAt(index);
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Task $deletedTaskTitle deleted"),
                          ),
                        );
                      },
                      background: Container(
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      child: TaskItem(
                        title: tasks[index]['title'],
                        desc: tasks[index]['desc'],
                        priority: tasks[index]['priority'],
                        status: tasks[index]['status'],
                        user: tasks[index]['user'],
                        date: tasks[index]['date'],
                        editOnTap: tasks[index]['title'] == "Demo Task"
                            ? () {}
                            : () {
                                _navigateToEditTask(context, index);
                              },
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 40),
                backgroundColor: blue,
              ),
              onPressed: () => _navigateToAddTask(context),
              child: Text(
                'Add Task',
                style: TextStyle(color: white, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
