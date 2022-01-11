import 'package:flutter/material.dart';
import 'package:internship_managing_system/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_content_list.dart';
import 'package:internship_managing_system/models/form_add.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  @override
  State<FormPage> createState() => _HomePageState();
}

class _HomePageState extends State<FormPage> {
  String? isEmpty(String val) {
    String? text;
    setState(() {
      if (val.isEmpty) {
        text = 'Boş bırakılamaz';
      }
    });
    return text;
  }

  final FormData _formData = FormData();
  late FormData? args;
  late int? index;
  FormArguments? formArguments;
  @override
  Widget build(BuildContext context) {
    formArguments = ModalRoute.of(context)?.settings.arguments as FormArguments?;

    if (formArguments != null ) {
      args=formArguments?.formData;
      index=formArguments?.index;
      //textField
      _kayit.text = args!.getKayitNo();
      _yas.text = args!.getYas();
      _sikayet.text = args!.getSikayet();
      _ayirici.text = args!.getAyiriciTani();
      _kesin.text = args!.getKesinTani();
      _tedavi.text = args!.getTedaviYontemi();

        //dropdown
      _valueCinsiyet = args!.getCinsiyet();
      _valueDoktor = args!.getDoktor();
      _valueEtkilesim = args!.getEtkilesimTuru();
      _valueKapsam = args!.getKapsam();
      _valueOrtam = args!.getOrtam();
      _valueStajTuru = args!.getStajTuru();

    }
    return Scaffold(
      backgroundColor: const Color(0xffffe0b2),
      appBar: AppBar(
        title: const Text('Hasta Etkileşim Kaydı'),
        centerTitle: true,
        backgroundColor: const Color(0xffffb74d),
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
                  var listDoktor = items[0].doktorItems;
                  return Form(
                    key: _formKey,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        myDropDownContainer(_valueStajTuru, listStajTuru,
                            hintTextStajTuru, onChangedStajTuru),
                        myDropDownContainer(_valueDoktor, listDoktor,
                            hintTextDoktor, onChangedDoktor),
                        myDropDownContainer(_valueCinsiyet, listCinsiyet,
                            hintTextCinsiyet, onChangedCinsiyet),
                        myDropDownContainer(_valueEtkilesim, listEtkilesim,
                            hintTextEtkilesim, onChangedEtkilesim),
                        myDropDownContainer(_valueKapsam, listKapsam,
                            hintTextKapsam, onChangedKapsam),
                        myDropDownContainer(_valueOrtam, listOrtam,
                            hintTextOrtam, onChangedOrtam),
                        myTextFieldRow(20, "Kayıt No: ", 10,
                            _formData.setKayitNo, isEmpty, _kayit),
                        myTextFieldRow(20, "Hastanın Yaşı:", 3,
                            _formData.setYas, isEmpty, _yas),
                        myTextFieldRow(20, "Şikayet:", 10, _formData.setSikayet,
                            isEmpty, _sikayet),
                        myTextFieldRow(50, "Ayırıcı Tanı:", 50,
                            _formData.setAyiriciTani, isEmpty, _ayirici),
                        myTextFieldRow(50, "Kesin Tanı:", 50,
                            _formData.setKesinTani, isEmpty, _kesin),
                        myTextFieldRow(50, "Tedavi Yöntemi:", 100,
                            _formData.setTedaviYontemi, isEmpty, _tedavi),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            submitButton(context, "Taslağa At"),
                            submitButton(context, "GÖNDER"),
                          ],
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
    );
  }

  //Kullanıcı kaydet butonuna basarsa local olarak kaydedecek

  Container submitButton(BuildContext context, String title) {
    return Container(
      width: 120,
      height: 50,
      margin: const EdgeInsets.all(12),
      child: TextButton(
        onPressed: () {
          setState(() {
            if (formArguments != null) {
              print("form arg is not null");
              Provider.of<FormAdd>(context, listen: false)
                  .updateUserList(index!, _formData);
            } else {
              print("this one executed");
              Provider.of<FormAdd>(context, listen: false)
                  .addNewFormToList(_formData);
            }


            alertDialog(context).then((_) => _formKey.currentState!.reset());
          });
        },
        child: Text(
          title,
          style: kTextStyle.copyWith(
              fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            const Color(0xffffa726),
          ),
        ),
      ),
    );
  }

//DropDownWidget
  Container myDropDownContainer(
      String initialVal, List<String> listItems, String text, Function myFunc) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              text,
              style: kTextStyle,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.orangeAccent,
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonFormField<String>(
                //    autovalidateMode: AutovalidateMode.always,
                //menuMaxHeight: 300,
                validator: (value) {
                  if (value!.isEmpty) {
                    return " null gönderdi";
                  }
                },
                decoration: const InputDecoration(border: InputBorder.none),
                isExpanded: true,
                //onTap: () => myFunc,
                //borderRadius: BorderRadius.circular(5),
                value: initialVal,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: Colors.black38,
                ),
                iconSize: 24,
                elevation: 16,
                dropdownColor: Colors.deepOrange,
                style: kTextStyle.copyWith(color: Colors.black),
                onChanged: (val) => myFunc(val),
                items: listItems.map<DropdownMenuItem<String>>((String? val) {
                  return DropdownMenuItem(
                    //TODO: Set default values
                    value: val == null ? val = initialVal : val = val,
                    child: Text(
                      val,
                      style: kTextStyle.copyWith(color: Colors.black),
                    ),
                  );
                }).toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  //TextFieldWidget
  Row myTextFieldRow(
      double height,
      String text,
      int? maxLength,
      Function function,
      Function regexFunction,
      TextEditingController controller) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          width: 80,
          height: height,
          child: Text(
            text,
            style: kTextStyle.copyWith(color: Colors.black54),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: (value) => regexFunction(value),
            onChanged: (input) {
              function(input);
            },
            autofocus: false,
            textAlignVertical: TextAlignVertical.bottom,
            style: kTextStyle.copyWith(fontSize: 16),
            maxLength: maxLength,
            maxLines: null, //TODO:Arrange maxlines for the inputs
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.fromLTRB(0, 0, 0, height),
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              // labelStyle:kTextStyle.copyWith(fontSize: 16, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Future<List<FormContent>> readJsonData() async {
    final jsonData = await rootBundle.rootBundle.loadString('assets/json/formdata.json');
    return [
      for (final e in json.decode(jsonData)) FormContent.fromJson(e),
    ];
  }

  final _formKey = GlobalKey<FormState>();

  String _valueEtkilesim = "Gözlem";
  String _valueKapsam = "Öykü";
  String _valueOrtam = "Poliklinik";
  String _valueDoktor = "Diğer";
  String _valueStajTuru = "Ortopedi";
  String _valueCinsiyet = "Erkek"; // initial value
  final String hintTextCinsiyet = "Cinsiyet:";
  final String hintTextStajTuru = "Staj Türü:";
  final String hintTextEtkilesim = "Etkileşim Türü:";
  final String hintTextKapsam = "Kapsam:";
  final String hintTextOrtam = "Gerçekleştiği Ortam:";
  final String hintTextDoktor = "Klinik Eğitici:";

  final TextEditingController _kayit = TextEditingController();
  final TextEditingController _yas = TextEditingController();
  final TextEditingController _sikayet = TextEditingController();
  final TextEditingController _ayirici = TextEditingController();
  final TextEditingController _kesin = TextEditingController();
  final TextEditingController _tedavi = TextEditingController();

  void onChangedCinsiyet(String? newVal) {
    setState(() {
      _valueCinsiyet = newVal!;
      _formData.setCinsiyet(_valueCinsiyet);
    });
  }

  void onChangedStajTuru(String newVal) {
    setState(() {
      _valueStajTuru = newVal;
      _formData.setStajTuru(newVal);
    });
  }

  void onChangedEtkilesim(String newVal) {
    setState(() {
      _valueEtkilesim = newVal;
      _formData.setEtkilesimTuru(newVal);
    });
  }

  void onChangedKapsam(String newVal) {
    setState(() {
      _valueKapsam = newVal;
      _formData.setKapsam(newVal);
    });
  }

  void onChangedOrtam(String newVal) {
    setState(() {
      _valueOrtam = newVal;
      _formData.setOrtam(newVal);
    });
  }

  void onChangedDoktor(String newVal) {
    setState(() {
      _valueDoktor = newVal;
      _formData.setDoktor(newVal);
    });
  }
}
