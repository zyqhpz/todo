import 'package:flutter/material.dart';
import 'package:todo/database_helper.dart';
import 'package:todo/screen/taskpage.dart';
import 'package:todo/screen/widgets.dart';

import '../model/task.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/homepage.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.only(
          top: 150,
          left: 20,
          right: 20,
          bottom: 20,
        ),
        width: double.infinity,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                    bottom: 24,
                  ),
                ),
                Expanded(
                  child: ScrollConfiguration(
                    behavior: NoGlowBehavior(),
                    child: FutureBuilder(
                      initialData: [],
                      future: _dbHelper.getTasks(),
                      builder: (context, AsyncSnapshot snapshot) {
                        // var data = (snapshot.data as List<Task>).toList();
                        var data = snapshot.data;
                        return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => TaskPage(
                                      task: data[index],
                                    ),
                                  ),
                                ).then(
                                  (value) => setState(() {
                                    // data.removeAt(index);
                                  }),
                                );
                              },
                              child: TaskCardWidget(
                                title: data[index].title,
                                description: data[index].description,
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TaskPage(
                        task: Task(
                          title: '',
                          description: '',
                        ),
                      ),
                    ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                child: Icon(Icons.add),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
