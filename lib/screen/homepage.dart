import 'package:flutter/material.dart';
import 'package:todo/screen/taskpage.dart';
import 'package:todo/screen/widgets.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
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
                    child: ListView(
                      children: [
                        TaskCardWidget(
                          title: 'Task 1',
                          description: 'This is a task description for task 1',
                        ),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                        TaskCardWidget(),
                      ],
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TaskPage()));
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
