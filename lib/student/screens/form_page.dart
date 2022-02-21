import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/custom_alert.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_content_list.dart';
import 'package:internship_managing_system/models/form_list.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/custom_snackbar.dart';
import 'package:internship_managing_system/student/screens/drafts.dart';
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

  @override
  initState() {
    fetchFormContent();
    super.initState();
  }

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
      _doktorController.text = args!.getDoktor();
      _valueEtkilesim = args!.getEtkilesimTuru();
      _valueKapsam = args!.getKapsam();
      _valueOrtam = args!.getOrtam();
      _stajTuruController.text = args!.getStajTuru();
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
                  var listOfCinsiyet = ['Erkek', 'Kadın', 'Diğer'];


                  Map<String, dynamic> map = {
                    'doktor': listOfDoktor,
                    'etkilesim': listOfEtkilesimTuru,
                    'kapsam': listOfKapsam,
                    'ortam': listOfOrtam,
                    'stajTuru': listOfStajTuru,
                    'cinsiyet': listOfCinsiyet,
                  };
                  return isLoading ? spinkit : formWidget(map);
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
            submitButton(Icons.send, context, "İLET", formIlet),
            formArguments != null
                ? submitButton(Icons.delete, context, "SİL", handleDelete)
                : Container(),
            submitButton(Icons.drafts_sharp, context, "SAKLA", formSakla),
          ],
        ),
      ),
    );
  }

  Form formWidget(Map<String, dynamic> map) {
    return Form(
      key: _formKey,
      child: ListView(
        shrinkWrap: true,
        children: [
          customTypeAhead(map['stajTuru'], _stajTuruController,
              _selectedStajTuru, 'Staj Türü'),
          customTypeAhead(
              map['doktor'], _doktorController, _selectedDoktor, 'Doktor'),
          customDropDown(_valueCinsiyet, map['cinsiyet'], hintTextCinsiyet,
              onChangedCinsiyet),
          customDropDown(_valueEtkilesim, map['etkilesim'], hintTextEtkilesim,
              onChangedEtkilesim),
          customDropDown(
              _valueKapsam, map['kapsam'], hintTextKapsam, onChangedKapsam),
          customDropDown(
              _valueOrtam, map['ortam'], hintTextOrtam, onChangedOrtam),
          const SizedBox(
            height: 20,
          ),
          customTextField(
              1, "Kayıt No ", 10, _formData.setKayitNo, isEmpty, _kayit, 80),
          customTextField(
              1, "Hastanın Yaşı", 3, _formData.setYas, isNumeric, _yas, 80),
          customTextField(
              1, "Şikayet", 10, _formData.setSikayet, isEmpty, _sikayet, 80),
          customTextField(1, "Ayırıcı Tanı", 10, _formData.setAyiriciTani,
              isEmpty, _ayirici, 80),
          customTextField(5, "Kesin Tanı", 50, _formData.setKesinTani, isEmpty,
              _kesin, 130),
          customTextField(5, "Tedavi Yöntemi", 200, _formData.setTedaviYontemi,
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
  String _valueEtkilesim = 'Gözlem';
  String _valueKapsam = 'Öykü';
  String _valueOrtam = 'Poliklinik';

  String? _selectedStajTuru;
  String? _selectedDoktor;
  String _valueCinsiyet = 'Erkek'; // initial value
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
  final TextEditingController _stajTuruController = TextEditingController();
  final TextEditingController _doktorController = TextEditingController();
  bool isLoading = false;

  void onChangedCinsiyet(String? newVal) {
    print(newVal);
    if (formArguments != null) {
      formArguments?.formData.setCinsiyet(newVal!);
    } else {
      setState(() {
        _valueCinsiyet = newVal!;

        _formData.setCinsiyet(_valueCinsiyet);
        print(_formData.getCinsiyet());
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

  //TODO: dropdown dışında hem anasayfadan hem de draft kısmından gönderim yapılabiliyor.
  void formSakla() async {
    if (formArguments != null) {
      setFormArgumentState();
      await _helper.update(formArguments!.formData);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla güncellendi.');

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Drafts()));
    } else {
      setFormDataState();
      await _helper.insert(_formData).then((value) {
        customSnackBar(context, 'Başarıyla taslağa kaydedildi');
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

  void formIlet() async {
    if (formArguments != null) {
      if (_formKey.currentState!.validate()) {
        setFormArgumentState();
        bool res = await _mySqlHelper.insertData(formArguments!.formData);
        if (res) {
          _helper.update(formArguments!.formData);
          customSnackBar(context, 'Başarıyla gönderildi');
        } else {
          errorAlert(context);
        }
      }
    } else {
      if (_formKey.currentState!.validate()) {
        setFormDataState();
        print(_formData.stajTuru);
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

  void setFormArgumentState() {
    //textfield
    formArguments?.formData.setKayitNo(_kayit.text);
    formArguments?.formData.setYas(_yas.text);
    formArguments?.formData.setSikayet(_sikayet.text);
    formArguments?.formData.setAyiriciTani(_ayirici.text);
    formArguments?.formData.setKesinTani(_kesin.text);
    formArguments?.formData.setTedaviYontemi(_tedavi.text);

  //typeahead
    formArguments?.formData.setStajTuru(_stajTuruController.text);
    formArguments?.formData.setDoktor(_doktorController.text);

   //other
    formArguments?.formData.setTarih();
    formArguments?.formData.setStatus('waiting');
  }

  void setFormDataState() {
    //typeahead
    _formData.setStajTuru(_stajTuruController.text);
    _formData.setDoktor(_doktorController.text);
  //dropdown
    _formData.setEtkilesimTuru(_valueEtkilesim);
    _formData.setKapsam(_valueKapsam);
    _formData.setCinsiyet(_valueCinsiyet);
    _formData.setOrtam(_valueOrtam);

    //other
    _formData.setTarih();
    _formData.setStatus('waiting');
  }

/*  Future<List<FormContent>> readJsonData() async {
    final jsonData =
        await root_bundle.rootBundle.loadString('assets/json/formdata.json');
    return [
      for (final e in json.decode(jsonData)) FormContent.fromJson(e),
    ];
  }*/
/*  void onChangedStajTuru(String? newVal) {
    if (formArguments != null) {
      formArguments?.formData.setStajTuru(newVal!);
    } else {
      setState(() {
        _selectedStajTuru = newVal!;
        _formData.setStajTuru(newVal);
      });
    }
  }*/

/*void handleSubmit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (formArguments != null) {
        formArguments?.formData.setKayitNo(_kayit.text);
        formArguments?.formData.setYas(_yas.text);
        formArguments?.formData.setSikayet(_sikayet.text);
        formArguments?.formData.setAyiriciTani(_ayirici.text);
        formArguments?.formData.setKesinTani(_kesin.text);
        formArguments?.formData.setTedaviYontemi(_tedavi.text);
        onChangedCinsiyet(_valueCinsiyet);
        onChangedStajTuru(_selectedStajTuru);
        // onChangedDoktor(_valueDoktor);
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
        */ /*  onChangedCinsiyet(_valueCinsiyet);
        onChangedStajTuru(_valueStajTuru);
        onChangedDoktor(_valueDoktor);
        onChangedEtkilesim(_valueEtkilesim);
        onChangedKapsam(_valueKapsam);
        onChangedOrtam(_valueOrtam);*/ /*
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
*/
/*
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
  }*/
}
