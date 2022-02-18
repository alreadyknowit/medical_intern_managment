import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/custom_alert.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_content_list.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/custom_snackbar.dart';
import 'package:internship_managing_system/student/services/MySqlHelper.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'dart:convert';

import '../widgets/widgets.dart';

//TODO: add loading page until the form loaded
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
    @override
    initState() {
      fetchFormContent();
      super.initState();
    }

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

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: fetchFormContent(), //readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else if (snapshot.hasData) {
                  var listOfContent = snapshot.data as List<List<String>>;
                  var listOfDoktor = listOfContent[0];
                  var listOfStajTuru = listOfContent[1];
                  var listOfCinsiyet = ['Erkek', 'Kadın', 'Diğer'];
                  var listOfKapsam = [
                    "Öykü",
                    "Fizik Bakı",
                    "Tanısal akıl Yürütme",
                    "Teropötik akıl yürütme"
                  ];
                  var listOfOrtam = [
                    "Poliklinik",
                    "Servis",
                    "Acil",
                    "Ameliyathane",
                    "Dış Kurum"
                  ];
                  var listOfEtkilesimTuru = [
                    "Gözlem",
                    "Yardımla yapma",
                    "Yardımsız yapma",
                    "Sanal olgu"
                  ];

                  _valueDoktor = listOfDoktor[0];
                  _valueEtkilesim = listOfEtkilesimTuru[0];
                  _valueKapsam = listOfKapsam[0];
                  _valueOrtam = listOfOrtam[0];
                  _valueStajTuru = listOfStajTuru[0];
                  _valueCinsiyet = listOfCinsiyet[0];

                  Map<String,dynamic> map ={
                    'doktor':listOfDoktor,
                    'etkilesim':listOfEtkilesimTuru,
                    'kapsam':listOfKapsam,
                    'ortam':listOfOrtam,
                    'stajTuru':listOfStajTuru,
                    'cinsiyet':listOfCinsiyet,
                  };

                  return isLoading
                      ? spinkit
                      : formWidget(map);
                } else {
                  return Center(
                    child: spinkit,
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

  Form formWidget(Map<String,dynamic> map) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          customTypeAhead(map['stajTuru']),
          myDropDownContainer(_valueStajTuru, map['stajTuru'], hintTextStajTuru,
              onChangedStajTuru),
          myDropDownContainer(
              _valueDoktor, map['doktor'], hintTextDoktor, onChangedDoktor),
          myDropDownContainer(_valueCinsiyet, map['cinsiyet'], hintTextCinsiyet,
              onChangedCinsiyet),
          myDropDownContainer(_valueEtkilesim, map['etkilesim'], hintTextEtkilesim,
              onChangedEtkilesim),
          myDropDownContainer(
              _valueKapsam, map['kapsam'], hintTextKapsam, onChangedKapsam),
          myDropDownContainer(
              _valueOrtam, map['ortam'], hintTextOrtam, onChangedOrtam),
          const SizedBox(
            height: 20,
          ),
          myTextFieldRow(
              1, "Kayıt No ", 10, _formData.setKayitNo, isEmpty, _kayit, 80),
          myTextFieldRow(
              1, "Hastanın Yaşı", 3, _formData.setYas, isNumeric, _yas, 80),
          myTextFieldRow(
              1, "Şikayet", 10, _formData.setSikayet, isEmpty, _sikayet, 80),
          myTextFieldRow(1, "Ayırıcı Tanı", 10, _formData.setAyiriciTani,
              isEmpty, _ayirici, 80),
          myTextFieldRow(5, "Kesin Tanı", 50, _formData.setKesinTani, isEmpty,
              _kesin, 130),
          myTextFieldRow(5, "Tedavi Yöntemi", 200, _formData.setTedaviYontemi,
              isEmpty, _tedavi, 130),
        ],
      ),
    );
  }

  final FormData _formData = FormData();
  late FormData? args;
  late int? index;
  FormArguments? formArguments;
  final _formKey = GlobalKey<FormState>();
  late String _valueEtkilesim;
  late String _valueKapsam;
  late String _valueOrtam;
  late String _valueDoktor;
  late String _valueStajTuru;
  late String _valueCinsiyet; // initial value
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
  bool isLoading = false;

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

  void handleDelete() {
    setState(() {
      _helper.remove(formArguments!.formData.id);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla silindi');
      //  Navigator.pop(context, MaterialPageRoute(builder: (context) => Drafts()));
    });
  }

  void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      if (formArguments != null) {
        formArguments?.formData.setKayitNo(_kayit.text);
        formArguments?.formData.setYas(_yas.text);
        formArguments?.formData.setSikayet(_sikayet.text);
        formArguments?.formData.setAyiriciTani(_ayirici.text);
        formArguments?.formData.setKesinTani(_kesin.text);
        formArguments?.formData.setTedaviYontemi(_tedavi.text);
        onChangedCinsiyet(_valueCinsiyet);
        onChangedStajTuru(_valueStajTuru);
        onChangedDoktor(_valueDoktor);
        onChangedEtkilesim(_valueEtkilesim);
        onChangedKapsam(_valueKapsam);
        onChangedOrtam(_valueOrtam);
        formArguments?.formData.setTarih();
        formArguments?.formData.setStatus('waiting');
        bool res =
            await _mySqlHelper.insertData(formArguments!.formData).then((val) {
          //  _helper.update(formArguments!.formData);
          return val;
        });
        if (res) {
          customSnackBar(context, 'Başarıyla gönderildi');
        } else {
          errorAlert(context);
        }
      } else {
        onChangedCinsiyet(_valueCinsiyet);
        onChangedStajTuru(_valueStajTuru);
        onChangedDoktor(_valueDoktor);
        onChangedEtkilesim(_valueEtkilesim);
        onChangedKapsam(_valueKapsam);
        onChangedOrtam(_valueOrtam);
        _formData.setTarih();
        _formData.setStatus('waiting');
        isLoading = true;
        bool res = await _mySqlHelper.insertData(_formData).then((val) {
          setState(() {
            isLoading = false;
            _formKey.currentState?.dispose();
          });
          return val;
        });
        if (res) {
          customSnackBar(context, 'Başarıyla gönderildi');
        } else {
          errorAlert(context);
        }
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
        _formData.setTarih();

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

  Future<List<List<String>>> fetchFormContent() async {
    List<List<String>> res = [];

    var listDoktor = await _mySqlHelper.fetchFormContent(
        _mySqlHelper.columnDoktorName, _mySqlHelper.doktorTableName);
    var listStajTuru = await _mySqlHelper.fetchFormContent(
        _mySqlHelper.columnStajTuruName, _mySqlHelper.stajTuruTableName);
    res.add(listDoktor);
    res.add(listStajTuru);
    return res;
  }

  Future<List<FormContent>> readJsonData() async {
    final jsonData =
        await root_bundle.rootBundle.loadString('assets/json/formdata.json');
    return [
      for (final e in json.decode(jsonData)) FormContent.fromJson(e),
    ];
  }
}
