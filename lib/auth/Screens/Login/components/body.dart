import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../DBURL.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../../Home_Page/home_page.dart';
import '../../Signup/components/background.dart';
import '../../Signup/signup_screen.dart';

class Body extends StatefulWidget {

  @override
  State<Body> createState() => BodyState();
}

class BodyState extends State<Body> {
  final GlobalKey<FormState> formKey = GlobalKey();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "MLBook",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/stethoscope.svg",
              height: size.height * 0.35,
            ),
            SizedBox(height: size.height * 0.03),
            TextFormField(
              controller: emailController,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                hintText: "Oasis/Telefon numarası",
                border: InputBorder.none,
              ),
            ),
            TextFormField(
              controller: passwordController,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                hintText: "Şifre",
                border: InputBorder.none,
              ),
            ),
            SizedBox(height: size.height * 0.03),
            RoundedButton(
              text: "GİRİŞ",
              press: () {
                if(emailController.text.startsWith("0") || emailController.text.startsWith("5")){
                  login(emailController.text, passwordController.text, "a");

                }
                else if(emailController.text.startsWith("2")){
                  login(emailController.text, passwordController.text, "s");
                }else{
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text("Giriş bilgileri hatalı.")));
                }
              },
            ),
          /*  AlreadyHaveAnAccountCheck(
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return SignUpScreen();
                    },
                  ),
                );
              },
            ),*/
          ],
        ),
      ),
    );
  }

  Future<void> login(String no, String pass,String role) async {
    if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty) {
      var response = await http.post(Uri.parse("${DBURL.url}/login?no=$no&password=$pass&role=$role"));

      if (response.statusCode == 200) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('email', emailController.text);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      } else if(response.statusCode == 500) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: const Text("Giriş bilgileri hatalı.")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text("Bir hata oluştu.")));
    }
  }
}
