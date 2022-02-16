import 'package:flutter/material.dart';
import 'package:internship_managing_system/attending_physician/provider/feedback_position_provider.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/student/screens/side_bar.dart';
import 'package:provider/provider.dart';
import 'attending_physician/attending_physician.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const InternshipManagingSystem());
}

class InternshipManagingSystem extends StatelessWidget {
  const InternshipManagingSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<FormList>(create: (context) => FormList()),
        ChangeNotifierProvider<FormData>(create: (context) => FormData()),
        ChangeNotifierProvider(create: (context) => FeedbackPositionProvider()),
      ],
      builder: (context, _) => MaterialApp(
        theme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home:SideBar(),//AttendingPhysician(),
      ),
    );
  }

}

