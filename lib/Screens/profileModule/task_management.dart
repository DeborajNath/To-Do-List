import 'package:flutter/material.dart';
import 'package:task_management/Data/Constants/colors.dart';
import 'package:task_management/Data/Constants/dimensions.dart';
import 'package:task_management/Data/Constants/routes.dart';
import 'package:task_management/Screens/profileModule/view_task.dart';

class TaskManagement extends StatefulWidget {
  const TaskManagement({super.key});

  @override
  State<TaskManagement> createState() => _TaskManagementState();
}

class _TaskManagementState extends State<TaskManagement> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: blue,
        centerTitle: true,
        title: Text(
          'Task Management',
          style: TextStyle(color: white),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Column(
          children: [
            InkWell(
              onTap: () {
                Future.microtask(() {
                  RoutingService.goto(
                    context,
                    const ViewTask(),
                  );
                });
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 150 * Dimensions.heightF(context),
                  horizontal: 20 * Dimensions.widthP(context),
                ),
                child: Container(
                  height: 100 * Dimensions.heightF(context),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [darkBlue, blue, blue, white],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: darkBlue),
                  ),
                  child: Center(
                    child: Text(
                      "View Task",
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: white),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
