import 'package:flutter/material.dart';
import 'package:internship_managing_system/models/form_content_list.dart';
import 'package:internship_managing_system/models/new_form_add.dart';
import 'package:internship_managing_system/student/student_profile.dart';
import 'package:internship_managing_system/models/form_data.dart';
import '../constants.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

class StudentHomePage extends StatefulWidget {
  StudentHomePage({Key? key}) : super(key: key);

  @override
  State<StudentHomePage> createState() => _HomePageState();
}

class _HomePageState extends State<StudentHomePage> {
  final FormAdd _formAdd = FormAdd();
  FormData _formData = FormData();

  String _valueEtkilesim = "Gözlem";
  String _valueKapsam = "Öykü";
  String _valueOrtam = "Poliklinik";
  String _valueDoktor = "Diğer";
  String _valueStajTuru = "Ortopedi";
  String _valueCinsiyet = "Diğer";
  final String hintTextCinsiyet = "Cinsiyet:";
  final String hintTextStajTuru = "Staj Türü:";
  final String hintTextEtkilesim = "Etkileşim Türü:";
  final String hintTextKapsam = "Kapsam:";
  final String hintTextOrtam = "Gerçekleştiği Ortam:";
  final String hintTextDoktor = "Klinik Eğitici:";

  void onChangedCinsiyet(String newVal) {

    setState(() {
      _valueCinsiyet=newVal;
      _formData.setCinsiyet(newVal);
    });
  }

  void onChangedStajTuru(String newVal) {
    setState(() {
      _valueStajTuru=newVal;
      _formData.setStajTuru(newVal);
    });
  }

  void onChangedEtkilesim(String newVal) {
    setState(() {
      _valueEtkilesim=newVal;
      _formData.setEtkilesimTuru(newVal);
    });
  }

  void onChangedKapsam(String newVal) {
    setState(() {
      _valueKapsam=newVal;
      _formData.setKapsam(newVal);
    });
  }

  void onChangedOrtam(String newVal) {
    setState(() {
      _valueOrtam=newVal;
      _formData.setOrtam(newVal);
    });
  }

  void onChangedDoktor(String newVal) {
    setState(() {
      _valueDoktor=newVal;
      _formData.setDoktor(newVal);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC9A7E3),
      appBar: AppBar(
        //  backgroundColor: Colors.teal.shade400,
        title: const Text('Hasta Etkileşim Kaydı'),
        centerTitle: true,
        backgroundColor: const Color(0xffB27FDA),
        elevation: 0,
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  var items = snapshot.data as List<dynamic>;

                  var listStajTuru = items[0].stajTuruItems;
                  var listCinsiyet = items[0].cinsiyetItems;
                  var listEtkilesim = items[0].etkilesimTuruItems;
                  var listKapsam = items[0].kapsamItems;
                  var listOrtam = items[0].ortamItems;
                  var listDoktor= items[0].doktorItems;
                  return ListView(
                    children: [
                      myTextFieldRow("Kayıt No: ", 10, _formData.setKayitNo),
                      myDropDownContainer(_valueStajTuru, listStajTuru,
                          hintTextStajTuru, onChangedStajTuru),
                      myDropDownContainer(_valueDoktor, listDoktor, hintTextDoktor, onChangedDoktor),
                      myTextFieldRow("Hastanın Yaşı:", 3, _formData.setYas),
                      myDropDownContainer(_valueCinsiyet, listCinsiyet,
                          hintTextCinsiyet, onChangedCinsiyet),
                      myTextFieldRow("Şikayet:", 10, _formData.setSikayet),
                      myTextFieldRow(
                          "Ayırıcı Tanı:", 50, _formData.setAyiriciTani),
                      myTextFieldRow("Kesin Tanı:", 50, _formData.setKesinTani),
                      myTextFieldRow(
                          "Tedavi Yöntemi:", 100, _formData.setTedaviYontemi),
                      myDropDownContainer(_valueEtkilesim, listEtkilesim,
                          hintTextEtkilesim, onChangedEtkilesim),
                      myDropDownContainer(_valueKapsam, listKapsam,
                          hintTextKapsam, onChangedKapsam),
                      myDropDownContainer(_valueOrtam, listOrtam, hintTextOrtam,
                          onChangedOrtam),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            width: 150,
                            height: 50,
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  _formAdd.addNewFormToList(_formData);
                                  _formData = FormData();

                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => StudentProfile(
                                              formAdd: _formAdd)));
                                });
                              },
                              child: Text(
                                "GÖNDER",
                                style: kTextStyle.copyWith(fontSize: 20),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                  const Color(0xff4F4DBB),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }

  Future<List<FormContent>> readJsonData() async {
    final jsonData =
    await rootBundle.rootBundle.loadString('assets/json/formdata.json');
    return [
      for (final e in json.decode(jsonData)) FormContent.fromJson(e),
    ];
  }

  //TextFieldWidget
  Row myTextFieldRow(String text, int? maxLength, Function function) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: kTextStyle,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            focusNode: FocusNode(),
            onChanged: (input) {
              function(input);
            },
            autofocus: false,
            style: kTextStyle,
            maxLength: maxLength,
            maxLines: null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              //labelText: text,
              labelStyle:
              kTextStyle.copyWith(fontSize: 12, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

//DropDownWidget
  Container myDropDownContainer(String initialVal, List<String> listItems, String text, Function myFunc) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: kTextStyle,
          ),
          const SizedBox(
            width: 12,
          ),
          Center(
            child: Align(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: false,
                    onTap: () => myFunc,
                    borderRadius: BorderRadius.circular(5),
                    value: initialVal,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: Colors.black38,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Colors.white,
                    style: kTextStyle.copyWith(color: Colors.black),
                    onChanged: (val) => myFunc(val),
                    items:
                    listItems.map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                          style: kTextStyle.copyWith(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
