import 'package:flutter/material.dart';
import 'package:internship_managing_system/shared/custom_alert.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/shared/custom_snackbar.dart';
import 'package:internship_managing_system/student/services/MySqlHelper.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import '../widgets/widgets.dart';


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
  late bool isDeletable;
  @override
  Widget build(BuildContext context) {
    formArguments =
        ModalRoute.of(context)?.settings.arguments as FormArguments?;
    if (formArguments != null) {
      isDeletable=formArguments!.isDeletable ?? true;
      args = formArguments?.formData;
    //  index = formArguments?.index;
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
                  return const Center(child:  Text("Oops! Something went wrong."));
                } else if (snapshot.hasData) {
                  var listOfContent = snapshot.data as List<List<String>>;
                  var listOfStajTuru = listOfContent[1];
                  var listOfDoktor = listOfContent[0];
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
            formArguments != null && isDeletable
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
      child: SingleChildScrollView(
        child: Column(
        //  shrinkWrap: true,
          children: [
            customTypeAhead(map['stajTuru'], _stajTuruController,
                _selectedStajTuru, 'Staj Türü'),
            customTypeAhead(
                map['doktor'], _doktorController, _selectedDoktor, 'Doktor'),
            customDropDown(
                _valueOrtam, map['ortam'], hintTextOrtam, onChangedOrtam),
            customDropDown(
                _valueKapsam, map['kapsam'], hintTextKapsam, onChangedKapsam),
            customDropDown(_valueEtkilesim, map['etkilesim'], hintTextEtkilesim,
                onChangedEtkilesim),
            customDropDown(_valueCinsiyet, map['cinsiyet'], hintTextCinsiyet,
                onChangedCinsiyet),
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
      ),
    );
  }

  final FormData _formData = FormData();
  late FormData? args;
  //late int? index;
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
    if (formArguments != null) {
      formArguments?.formData.setCinsiyet(newVal!);
    } else {
      setState(() {
        _valueCinsiyet = newVal!;

        _formData.setCinsiyet(_valueCinsiyet);
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
        _formKey.currentState!.save();
        setFormDataState();
        isLoading = true;
        bool res = await _mySqlHelper.insertData(_formData).then((val) {
          setState(() {
            isLoading = false;
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

  String? isNumeric(String? num) {
    if (num == null) {
      return 'Boş bırakılamaz';
    } else if (int.tryParse(num) == null) {
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
}
