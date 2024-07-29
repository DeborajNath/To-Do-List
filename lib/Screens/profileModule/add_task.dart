// AddTask.dart

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:task_management/Data/Components/custom_text_form_field.dart';
import 'package:task_management/Data/Constants/colors.dart';
import 'package:task_management/Data/Constants/routes.dart';

class AddTask extends StatefulWidget {
  final Map<String, String>? task;
  final int? index;

  const AddTask({super.key, this.task, this.index});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  late TextEditingController titleController;
  late TextEditingController descController;
  late TextEditingController dueDateController;
  late DateTime _selectedDay;
  late String? _selectedStatus;
  late String? _selectedPriority;
  late String? _selectedUser;
  final List _priority = ['Low', 'Medium', 'High'];
  final List _status = ['To-Do', 'In Progress', 'Done'];
  final List _assignedUsers = [
    'George Bluth',
    'Janet Weaver',
    'Emma Wong',
    'Charles Morris',
    'Tracey Ramos',
  ];

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.task?['title'] ?? '');
    descController = TextEditingController(text: widget.task?['desc'] ?? '');
    dueDateController = TextEditingController(text: widget.task?['date'] ?? '');
    _selectedDay = widget.task != null
        ? DateFormat('yyyy-MM-dd').parse(widget.task!['date']!)
        : DateTime.now();
    _selectedStatus = widget.task?['status'] ?? 'To-Do';
    _selectedPriority = widget.task?['priority'] ?? 'Low';
    _selectedUser = widget.task?['user'] ?? 'George Bluth';
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    dueDateController.dispose();
    super.dispose();
  }

  void _showCalendar(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 400,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TableCalendar(
                firstDay: DateTime.now(),
                lastDay: DateTime(2100),
                focusedDay: _selectedDay,
                selectedDayPredicate: (day) => isSameDay(day, _selectedDay),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    dueDateController.text =
                        DateFormat('yyyy-MM-dd').format(selectedDay);
                  });
                  Navigator.pop(context);
                },
                headerStyle: const HeaderStyle(
                    formatButtonVisible: false, titleCentered: true),
              ),
            ],
          ),
        );
      },
    );
  }

  void _submitTask() {
    if (titleController.text.isNotEmpty &&
        descController.text.isNotEmpty &&
        dueDateController.text.isNotEmpty) {
      final newTask = {
        'title': titleController.text,
        'desc': descController.text,
        'priority': _selectedPriority,
        'status': _selectedStatus,
        'user': _selectedUser,
        'date': dueDateController.text,
      };
      Navigator.pop(context, {'task': newTask, 'index': widget.index});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill all the fields"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.task != null;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 40),
            backgroundColor: blue,
          ),
          onPressed: _submitTask,
          child: Text(
            'Submit',
            style: TextStyle(color: white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        title: Text(
          isEditing ? 'Edit Task' : 'Add Task',
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              CustomTextFormField(
                labelText: "Title",
                controller: titleController,
              ),
              const Gap(20),
              CustomTextFormField(
                labelText: "Description",
                controller: descController,
                maxLines: 5,
              ),
              const Gap(20),
              CustomTextFormField(
                controller: dueDateController,
                labelText: "Due Date",
                readOnly: true,
                suffixIcon: IconButton(
                  onPressed: () => _showCalendar(context),
                  icon: const Icon(
                    Icons.calendar_month,
                  ),
                ),
              ),
              const Gap(20),
              DropdownButtonFormField<String>(
                value: _selectedPriority,
                decoration: InputDecoration(
                  labelText: 'Priority',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _priority
                    .map((priority) => DropdownMenuItem<String>(
                          value: priority,
                          child: Text(priority),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedPriority = newValue;
                  });
                },
              ),
              const Gap(20),
              DropdownButtonFormField<String>(
                value: _selectedStatus,
                decoration: InputDecoration(
                  labelText: 'Status',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _status
                    .map((status) => DropdownMenuItem<String>(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedStatus = newValue;
                  });
                },
              ),
              const Gap(20),
              DropdownButtonFormField<String>(
                value: _selectedUser,
                decoration: InputDecoration(
                  labelText: 'Assigned User',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                items: _assignedUsers
                    .map((assignedUsers) => DropdownMenuItem<String>(
                          value: assignedUsers,
                          child: Text(assignedUsers),
                        ))
                    .toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedUser = newValue;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
