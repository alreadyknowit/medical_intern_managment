import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/custom_alert.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_content_list.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/student/services/DbService.dart';
import 'package:internship_managing_system/shared/custom_snackbar.dart';
import 'package:internship_managing_system/student/services/MySqlHelper.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:provider/provider.dart';
import 'package:internship_managing_system/shared/constants.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'dart:convert';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  @override
  State<FormPage> createState() => _HomePageState();
}

class _HomePageState extends State<FormPage> {
  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  final MySqlHelper _mySqlHelper = MySqlHelper();
  @override
  Widget build(BuildContext context) {
    formArguments =
        ModalRoute.of(context)?.settings.arguments as FormArguments?;
    if (formArguments != null) {
      args = formArguments?.formData;
      index = formArguments?.index;
      //textField
      _kayit.text = args!.getKayitNo();
      _yas.text = args!.getYas().toString();
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
        _helper.remove(formArguments!.formData.id);
        Navigator.pop(context);
        customSnackBar(context, 'Başarıyla silindi');
        //  Navigator.pop(context, MaterialPageRoute(builder: (context) => Drafts()));
      });
    }

    return Scaffold(
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
                        const SizedBox(
                          height: 20,
                        ),
                        myTextFieldRow(1, "Kayıt No ", 10, _formData.setKayitNo,
                            isEmpty, _kayit, 80),
                        myTextFieldRow(1, "Hastanın Yaşı", 3, _formData.setYas,
                            isNumeric, _yas, 80),
                        myTextFieldRow(1, "Şikayet", 10, _formData.setSikayet,
                            isEmpty, _sikayet, 80),
                        myTextFieldRow(1, "Ayırıcı Tanı", 10,
                            _formData.setAyiriciTani, isEmpty, _ayirici, 80),
                        myTextFieldRow(5, "Kesin Tanı", 50,
                            _formData.setKesinTani, isEmpty, _kesin, 130),
                        myTextFieldRow(5, "Tedavi Yöntemi", 200,
                            _formData.setTedaviYontemi, isEmpty, _tedavi, 130),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              })),
      bottomNavigationBar: SizedBox(
        height: 44,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            submitButton(Icons.send, context, "İLET", handleSubmit),
            formArguments != null
                ? submitButton(Icons.delete, context, "SİL", handleDelete)
                : Container(),
            submitButton(Icons.drafts_sharp, context, "SAKLA", handleSave),
          ],
        ),
      ),
    );
  }

  //Kullanıcı kaydet butonuna basarsa local olarak kaydedecek
  ElevatedButton submitButton(IconData icon, BuildContext context, String title,
      Function handleSubmit) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: PRIMARY_BUTTON_COLOR,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        minimumSize: const Size(120, double.infinity), //////// HERE
      ),
      onPressed: () => handleSubmit(),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Text(title),
      ),
    );
  }

//DropDownWidget
  Container myDropDownContainer(
      String initialVal, List<String> listItems, String text, Function myFunc) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            text,
            style: TEXT_STYLE,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(5)),
              child: DropdownButtonFormField<String>(
                decoration: const InputDecoration(border: InputBorder.none),
                isExpanded: true,
                value: initialVal,
                icon: const Icon(
                  Icons.arrow_downward,
                  color: ICON_COLOR,
                ),
                validator: (val) => val==null? 'Seçim zorunludur!'  : null,
                iconSize: 24,
                elevation: 16,
                dropdownColor: Colors.grey[800],
                style: TEXT_STYLE,
                onChanged: (val) => myFunc(val),
                items: listItems.map<DropdownMenuItem<String>>((String? val) {
                  return DropdownMenuItem(
                    value: val == null ? val = initialVal : val = val,
                    child: Center(
                      child: Text(
                        val,
                        style: TEXT_STYLE,
                      ),
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
  Padding myTextFieldRow(
      int minLine,
      String text,
      int? maxLength,
      Function function,
      Function regexFunction,
      TextEditingController controller,
      double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          SizedBox(
            child: Text(
              text,
              style: TEXT_STYLE,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            height: height,
            child: TextFormField(
              controller: controller,
              validator: (value) => regexFunction(value),
              onChanged: (input) => function(input.toString()),
              autofocus: false,
              textAlignVertical: TextAlignVertical.bottom,
              style: TEXT_STYLE.copyWith(fontSize: 16),
              maxLength: maxLength,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              minLines: minLine,
              expands: false,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                    borderRadius: BorderRadius.all(Radius.circular(3))),
                // labelStyle:kTextStyle.copyWith(fontSize: 16, color: Colors.white54),
              ),
            ),
          ),
        ],
      ),
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
    if (formArguments != null) {
      formArguments?.formData.setCinsiyet(newVal!);
    } else {
      setState(() {
        _valueCinsiyet = newVal!;
        _formData.setCinsiyet(_valueCinsiyet);
      });
    }
  }

  void onChangedStajTuru(String? newVal) {
    if (formArguments != null) {
      formArguments?.formData.setStajTuru(newVal!);
    } else {
      setState(() {
        _valueStajTuru = newVal!;
        _formData.setStajTuru(newVal);
      });
    }
  }

  void onChangedEtkilesim(String newVal) {
    if (formArguments != null) {
      formArguments?.formData.setEtkilesimTuru(newVal);
    } else {
      setState(() {
        _valueEtkilesim = newVal;
        _formData.setEtkilesimTuru(newVal);
      });
    }
  }

  void onChangedKapsam(String newVal) {
    if (formArguments != null) {
      formArguments?.formData.setKapsam(newVal);
    } else {
      setState(() {
        _valueKapsam = newVal;
        _formData.setKapsam(newVal);
      });
    }
  }

  void onChangedOrtam(String newVal) {
    if (formArguments != null) {
      formArguments?.formData.setOrtam(newVal);
    } else {
      setState(() {
        _valueOrtam = newVal;
        _formData.setOrtam(newVal);
      });
    }
  }

  void onChangedDoktor(String newVal) {
    if (formArguments != null) {
      formArguments?.formData.setDoktor(newVal);
    } else {
      setState(() {
        _valueDoktor = newVal;
        _formData.setDoktor(newVal);
      });
    }
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      onChangedCinsiyet(_valueCinsiyet);
      onChangedStajTuru(_valueStajTuru);
      onChangedDoktor(_valueDoktor);
      onChangedEtkilesim(_valueEtkilesim);
      onChangedKapsam(_valueKapsam);
      onChangedOrtam(_valueOrtam);
      _formData.setTarih();
      _formData.setStatus('waiting');
      print(_formData.getStatus());
      bool res = await _mySqlHelper.insertData(_formData).then((val) => val);
      if (res) {
        customSnackBar(context, 'Başarıyla gönderildi');
      } else {
        showMyDialog(context);
      }
    }
  }

  void handleSave() {
    setState(() {
      if (formArguments != null) {
        formArguments?.formData.setKayitNo(_kayit.text);
        formArguments?.formData.setYas(_yas.text);
        formArguments?.formData.setSikayet(_sikayet.text);
        formArguments?.formData.setAyiriciTani(_ayirici.text);
        formArguments?.formData.setKesinTani(_kesin.text);
        formArguments?.formData.setTedaviYontemi(_tedavi.text);
        formArguments?.formData.setTarih();
        _helper.update(formArguments!.formData);
        Navigator.pop(context);
        customSnackBar(context, 'Başarıyla taslağa kaydedildi');
      } else {
        _helper.insert(_formData);
        customSnackBar(context, 'Başarıyla taslağa kaydedildi');
      }
    });
  }

  String? isNumeric(String num) {
    if (int.tryParse(num) == null) {
      return 'Hastanın yaşı rakamlardan oluşmalıdır';
    }
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
        await root_bundle.rootBundle.loadString('assets/json/formdata.json');
    return [
      for (final e in json.decode(jsonData)) FormContent.fromJson(e),
    ];
  }
}
