import 'package:flutter/material.dart';
import 'package:internship_managing_system/constants.dart';
import 'package:internship_managing_system/student/student_home_page.dart';

class ApprovedPage extends StatelessWidget {
  const ApprovedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [

            Container(
              width: 120,
              height: 50,
              margin: const EdgeInsets.all(12),
              child: TextButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => StudentHomePage())),
                child: Text(
                  "Anasayfaya dön",
                  style: kTextStyle.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xffffa726),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
