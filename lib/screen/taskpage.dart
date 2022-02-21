import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screen/homepage.dart';

import '../model/task.dart';

class TaskPage extends StatefulWidget {
  final Task task;
  TaskPage({required this.task});

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  DatabaseHelper _dbhelper = DatabaseHelper();

  String _taskTitle = '';
  String _taskDescription = '';

  FocusNode? _focusTitle;
  FocusNode? _focusDescription;

  @override
  void initState() {
    if (widget.task != null) {
      _taskTitle = widget.task.title!;
      _taskDescription = widget.task.description!;
    }

    _focusTitle = FocusNode();
    _focusDescription = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _focusTitle?.dispose();
    _focusDescription?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 24, bottom: 6),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(24),
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            focusNode: _focusTitle,
                            onSubmitted: (value) async {
                              if (value != '') {
                                // widget.task.title = value;
                                // _dbhelper.updateTask(widget.task);
                                _taskTitle = value;

                                // setState to update _taskTitle value
                                setState(() {
                                  _taskTitle = value;
                                });

                                if (widget.task == null) {
                                  Task task = Task(
                                    id: null,
                                    title: value,
                                    description: '',
                                  );

                                  await _dbhelper.insertTask(task);
                                  task.id;
                                  print('new task has been added.');
                                } else {
                                  // update task title
                                  // widget.task.title = value;

                                  _focusDescription?.requestFocus();
                                  await _dbhelper.updateTaskTitle(
                                    widget.task.id,
                                    value,
                                  );
                                  print('update task');
                                }
                              }
                            },
                            controller: TextEditingController(
                              text: _taskTitle,
                            ),
                            decoration: InputDecoration(
                                hintText: 'Enter task title',
                                border: InputBorder.none),
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF1F1F1F),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextField(
                    focusNode: _focusDescription,
                    onSubmitted: (value) {
                      if (value != '') {
                        // _taskDescription = value;
                        setState(() {
                          _taskDescription = value;
                        });
                      }
                      // Task task = Task(
                      //   description: value,
                      // );

                      // if (value != null) {
                      //   _dbhelper.insertTask(task);
                      // }
                      _dbhelper.updateDescription(value, widget.task.id);
                      print('new description for this has been added.');
                    },
                    controller: TextEditingController(
                      text: _taskDescription,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Enter task description',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 24,
                      ),
                    ),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xFF1F1F1F),
                    ),
                  )
                ],
              ),
              Positioned(
                bottom: 24,
                right: 24,
                child: GestureDetector(
                  onTap: () {
                    setState(() {});
                    // int? id = ;
                    // String? title = ;
                    // String? description = ;
                    Task task = Task(
                      id: widget.task.id,
                      title: _taskTitle,
                      description: _taskDescription,
                    );
                    _dbhelper.updateTask(task);
                    print(
                        'task has been updated ${task.id} ${task.title} ${task.description}');
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(
                            // task: Task(
                            //   id: widget.task?.id,
                            //   title: _taskTitle,
                            //   description: _taskDescription,
                            // ),
                            ),
                      ),
                    );
                  },
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      //color: Color(0xFFFFCF00),
                      color: Color.fromARGB(255, 0, 183, 255),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
