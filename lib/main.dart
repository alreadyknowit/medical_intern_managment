import 'package:flutter/material.dart';
import 'package:internship_managing_system/attending_physician/attending_physician.dart';
import 'package:internship_managing_system/student/models/form_data.dart';
import 'package:internship_managing_system/student/models/form_list.dart';
import 'package:internship_managing_system/student/side_bar.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<FormList>(create: (context) => FormList()),
    ChangeNotifierProvider<FormData>(create: (context) => FormData()),
  ], child: const InternshipManagingSystem()));
}

class InternshipManagingSystem extends StatelessWidget {
  const InternshipManagingSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
       elevatedButtonTheme: ElevatedButtonThemeData(
         style: ButtonStyle(
          backgroundColor:MaterialStateProperty.all<Color>(Colors.orange)
         )
       ),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  //SideBar();
    AttendingPhysician();
  }
}
