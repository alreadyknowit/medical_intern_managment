import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/new_form_add.dart';
import 'package:internship_managing_system/student/approved_page.dart';
import 'package:internship_managing_system/student/side_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
      ChangeNotifierProvider<FormAdd>(
      create: (context) => FormAdd(),
      child: const InternshipManagingSystem()));
}

class InternshipManagingSystem extends StatelessWidget {
  const InternshipManagingSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FormAdd form= FormAdd();
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  SideBar();
  }
}
