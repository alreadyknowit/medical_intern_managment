import 'package:flutter/material.dart';
import 'package:internship_managing_system/student/student_forms.dart';
class SavedForms extends StatelessWidget {
  const SavedForms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StudentForms(title: 'Saved Forms',);
  }
}
