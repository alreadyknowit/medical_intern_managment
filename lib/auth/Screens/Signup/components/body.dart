import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import '../../../DBURL.dart';
import '../../../components/already_have_an_account_acheck.dart';
import '../../../components/rounded_button.dart';
import '../../../constants.dart';
import '../../Login/components/background.dart';
import '../../Login/components/login.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  var textController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              "SIGNUP",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            SvgPicture.asset(
              "assets/icons/doctor-296571.svg",
              height: size.height * 0.35,
            ),
            TextFormField(
              controller: textController,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: kPrimaryColor,
                ),
                hintText: "Oasis/Telefon numarası",
                border: InputBorder.none,
              ),
            ),
            RoundedButton(
              text: "Şifre Gönder",
              press: () {
                if(textController.text.startsWith("0") || textController.text.startsWith("5")){
                  sifreGonder(textController.text, "a");

                }
                else if(textController.text.startsWith("2")){
                  sifreGonder(textController.text, "s");
                }else{
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: const Text("Giriş bilgileri hatalı.")));
                }

              }
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
              login: false,
              press: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return LoginScreen();
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> sifreGonder(String no,String role) async {
    if (textController.text.isNotEmpty ) {
      var response = await http.post(Uri.parse("${DBURL.url}/login/check?no=$no&role=$role"));
      var result =jsonDecode(response.body);
      print(result);
      if (result==true) {
        if(role == 's'){
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Oasis mesaj kutunuza şifreniz gönderildi.")));
        }else{
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Telefonunuza yeni şifre gönderildi.")));
        }

      } else if(result==false) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Giriş bilgileri hatalı.")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Bir hata oluştu.")));
    }
  }
}
