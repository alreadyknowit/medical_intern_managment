import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/student_home_page.dart';



void main() {
  runApp(const InternshipManagingSystem());
}

class InternshipManagingSystem extends StatelessWidget {
  const InternshipManagingSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  HomePage(),
    );
  }
}
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudentHomePage();
  }
}

