import 'package:flutter/material.dart';

class TaskCardWidget extends StatelessWidget {
  // const TaskCardWidget({Key? key}) : super(key: key);

  final String? title;
  final String? description;
  TaskCardWidget({this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: 32,
        vertical: 24,
      ),
      margin: EdgeInsets.only(
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? 'No Title Added',
            style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              description ?? 'No Description Added',
              style: TextStyle(
                color: Color(0xFF8F8F8F),
                fontSize: 16,
                height: 1.5,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NoGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
