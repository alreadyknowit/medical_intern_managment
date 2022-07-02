import 'package:flutter/material.dart';
import 'package:internship_managing_system/attending_physician/provider/feedback_position_provider.dart';
import 'package:internship_managing_system/attending_physician/screens/attending_physician.dart';
import 'package:internship_managing_system/auth/Screens/Login/components/login.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/student/screens/side_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'auth/Screens/Home_Page/home_page.dart';

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
        ChangeNotifierProvider(create: (context) => FeedbackPositionProvider()),
        ChangeNotifierProvider(create: (context) => PatientLog())
      ],
      builder: (context, _) => MaterialApp(
        theme: ThemeData.dark(),
        themeMode: ThemeMode.dark,
        home:Direct(),


      ),
    );
  }
}


class Direct extends StatefulWidget {
  @override
  State<Direct> createState() => _DirectState();
}

class _DirectState extends State<Direct> {
   bool isSingedIn=false;
   String role = '';
  @override
  initState(){
   checkUser();
   checkType();
  }
   Future checkUser()async{
     SharedPreferences pref = await SharedPreferences.getInstance();
     setState(() { isSingedIn= pref.getBool('newUser') ?? false; });
     print(isSingedIn);
   }

   Future checkType()async{
     SharedPreferences pref = await SharedPreferences.getInstance();
     setState(() { role= pref.getString('role') ?? "s"; });
     print(role);
   }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:isSingedIn  ? Direct2(role: role,) : LoginScreen() ,//AttendingPhysician()//,
    );
  }
}

class Direct2 extends StatefulWidget {
  String? role ;
  Direct2({this.role});

  @override
  State<Direct2> createState() => _Direct2State();
}

class _Direct2State extends State<Direct2> {
  @override
  Widget build(BuildContext context) {
    return widget.role== 's' ? const SideBar() : widget.role == null ? LoginScreen() :AttendingPhysicianMain();
  }
}


