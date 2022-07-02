import 'package:flutter/material.dart';
import '../Login/components/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  String email = "" ;
  Future getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
    email = preferences.getString('email') ?? "";
});

  }
  Future logOut(BuildContext context) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('email');
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
  }
  @override
  void initState(){
    super.initState();
    getEmail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Welcome $email"),

            SizedBox(
              height: 50,
            ),
          OutlinedButton(

                onPressed: () {
                  logOut(context);
                },
              child: Icon(Icons.exit_to_app, size: 18),
                )
          ],
        ),
      ),
    );
  }
}
