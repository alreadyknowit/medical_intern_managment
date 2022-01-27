import 'package:flutter/material.dart';
import 'package:internship_managing_system/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_content_list.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/services/DbService.dart';
import 'package:internship_managing_system/shared/shared.dart';
import 'package:internship_managing_system/student/drafts.dart';
import 'package:provider/provider.dart';
import '../shared/constants.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'dart:convert';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  @override
  State<FormPage> createState() => _HomePageState();
}

class _HomePageState extends State<FormPage> {
  @override
  Widget build(BuildContext context) {
    formArguments =
        ModalRoute.of(context)?.settings.arguments as FormArguments?;
    if (formArguments != null) {
      args = formArguments?.formData;
      index = formArguments?.index;
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
    void handleDelete() {
      setState(() {
        Provider.of<FormList>(context, listen: false)
            .deleteFormInstance(index!);
        alertDraft(context, "Başarıyla silindi").then((_) => Navigator.push(
            context, MaterialPageRoute(builder: (builder) => Drafts())));
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xffffe0b2),
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
                            Expanded(
                              child: submitButton(Icons.drafts_sharp, context,
                                  "Sakla", handleSave),
                            ),
                            Expanded(
                              child: formArguments != null
                                  ? submitButton(Icons.delete, context, "Sil",
                                      handleDelete)
                                  : Container(),
                            ),
                            Expanded(
                              child: submitButton(
                                  Icons.send, context, "İlet", handleSubmit),
                            ),
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

  Container submitButton(IconData icon, BuildContext context, String title,
      Function handleSubmit) {
    return Container(
      width: 90,
      height: 50,
      margin: const EdgeInsets.all(12),
      child: TextButton(
        onPressed: () => handleSubmit(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              title,
              style: kTextStyle.copyWith(
                  fontSize: 14,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              width: 15,
            ),
            Icon(
              icon,
              color: Colors.white,
            ),
          ],
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
                  color: Color(0xffF9A825), borderRadius: BorderRadius.circular(5)),
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
                dropdownColor: Colors.orange,
                style: kTextStyle.copyWith(color: Colors.black),
                onChanged: (val) => myFunc(val),
                items: listItems.map<DropdownMenuItem<String>>((String? val) {
                  return DropdownMenuItem(
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
        Expanded(
          flex: 1,
          child: SizedBox(
            width: 80,
            height: height,
            child: Text(
              text,
              style: kTextStyle.copyWith(color: Colors.black54),
            ),
          ),
        ),
        /*   const SizedBox(
          width: 10,
        ),*/
        Expanded(
          flex: 2,
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

  final DbService _db = DbService();
  final FormData _formData = FormData();
  late FormData? args;
  late int? index;
  FormArguments? formArguments;
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

  void handleSubmit() {
    Future<FormData>? _futureFormData;
    setState(() {
      if (_formKey.currentState!.validate()) {
        _futureFormData = _db.createForm(
            _kayit.text,
            _valueStajTuru,
            _valueDoktor,
            _yas.text,
            _valueCinsiyet,
            _sikayet.text,
            _ayirici.text,
            _kesin.text,
            _tedavi.text,
            _valueOrtam,
            _valueEtkilesim,
            _valueKapsam);
        Provider.of<FormList>(context, listen: false).addSentList(_formData);
        alertSent(context);
      }
    });
  }

  void handleSave() {
    setState(() {
      if (formArguments != null) {
        Provider.of<FormList>(context, listen: false)
            .updateDraftList(index!, _formData);
      } else {
        Provider.of<FormList>(context, listen: false).addDraftList(_formData);
      }
    });
    alertDraft(context, "Başaryla taslağa kaydedildi")
        .then((_) => _formKey.currentState!.reset());
  }

  String? isEmpty(String val) {
    String? text;
    setState(() {
      if (val.isEmpty) {
        text = 'Boş bırakılamaz';
      }
    });
    return text;
  }

  Future<List<FormContent>> readJsonData() async {
    final jsonData =
        await rootBundle.rootBundle.loadString('assets/json/formdata.json');
    return [
      for (final e in json.decode(jsonData)) FormContent.fromJson(e),
    ];
  }
}
