import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';

import '../model/task.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({Key? key}) : super(key: key);

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
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
                            onSubmitted: (value) {
                              DatabaseHelper _dbhelper = DatabaseHelper();

                              Task task = Task(
                                id: null,
                                title: value,
                                description: '',
                              );

                              if (value != null) {
                                _dbhelper.insertTask(task);
                              }
                              print('new task has been added.');
                            },
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskPage(),
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
