import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:task_management/Data/Constants/colors.dart';

class TaskItem extends StatefulWidget {
  final String? title;
  final String? desc;
  final String? priority;
  final String? status;
  final String? user;
  final String? date;
  final void Function()? editOnTap;

  const TaskItem(
      {super.key,
      this.title,
      this.desc,
      this.priority,
      this.status,
      this.user,
      this.date,
      this.editOnTap});
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              isExpanded = !isExpanded;
            });
          },
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: black),
                  gradient: LinearGradient(
                    colors: [blue, white],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.title ?? "",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      AnimatedCrossFade(
                        firstChild: Container(),
                        secondChild: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Gap(10),
                            Text(
                              textAlign: TextAlign.center,
                              widget.desc ?? "",
                              style: TextStyle(fontSize: 16),
                            ),
                            Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Priority",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.priority ?? "",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Status",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.status ?? "",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "User",
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      widget.user ?? "",
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Due Date: ",
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      TextSpan(
                                        text: widget.date ?? "",
                                        style: TextStyle(
                                            color: black, fontSize: 16),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        crossFadeState: isExpanded
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        duration: Duration(milliseconds: 300),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                right: 5,
                top: 5,
                child: Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: widget.editOnTap,
                    child: Icon(
                      Icons.edit_note_outlined,
                      size: 40,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
