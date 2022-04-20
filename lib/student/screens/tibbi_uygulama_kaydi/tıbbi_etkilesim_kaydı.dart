import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/models/staj_turu_model.dart';
import 'package:internship_managing_system/shared/custom_snackbar.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';

import '../../../models/tibbi_form_data.dart';
import '../../../shared/custom_alert.dart';
import '../../widgets/widgets.dart';

class TibbiUygulama extends StatefulWidget {
  const TibbiUygulama({Key? key}) : super(key: key);
  @override
  State<TibbiUygulama> createState() => _TibbiUyglamaState();
}

class _TibbiUyglamaState extends State<TibbiUygulama> {
  @override
  initState() {
    fetchFormContent();
    super.initState();
  }

  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
  late bool isDeletable;
  @override
  Widget build(BuildContext context) {
    tibbiFormArguments =
        ModalRoute.of(context)?.settings.arguments as TibbiFormArguments?;
    if (tibbiFormArguments != null) {
      isDeletable = tibbiFormArguments!.isDeletable ?? true;
      args = tibbiFormArguments?.tibbiFormData;
      _kayit.text = args!.getKayitNo();

      //dropdown
      _valueTibbiOrtam = args!.getTibbiOrtam();
      _valueTibbiEtkilesimTuru = args!.getTibbiUygulama();
      //

      _doktorController.text = args!.getDoktor();
      _disKurum.text = args!.getDisKurum();
      _tibbiUygulama.text = args!.getTibbiUygulama();
      _stajTuruController.text = args!.getStajTuru();
    }

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: fetchFormContent(), //readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Oops! Something went wrong."));
                } else if (snapshot.hasData) {
                  var listOfContent = snapshot.data as List<List<String>>;
                  var listOfStajTuru = listOfContent[1];
                  var listOfDoktor = listOfContent[0];

                  var listOfOrtam = [
                    "Poliklinik",
                    "Servis",
                    "Acil",
                    "Yoğun Bakım",
                    "Ameliyathane",
                    "Dış Kurum"
                  ];
                  var listOfEtkilesimTuru = [
                    "Gözlem",
                    "Yardımla yapma",
                    "Yardımsız yapma",
                    "Sanal olgu",
                  ];

                  Map<String, dynamic> map = {
                    'doktor': listOfDoktor,
                    'etkilesim': listOfEtkilesimTuru,
                    'ortam': listOfOrtam,
                    'stajTuru': listOfStajTuru,
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
            tibbiFormArguments != null && isDeletable
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
            customDropDown(_valueTibbiEtkilesimTuru, map['etkilesim'],
                hintTextEtkilesim, onChangedEtkilesim),
            customDropDown(
                _valueTibbiOrtam, map['ortam'], hintTextOrtam, onChangedOrtam),
            customTextField(1, "Lütfen Dış Kurumu Yazınız", 10,
                _tibbiFormData.setDisKurum, isEmpty, _disKurum, 80),
            const SizedBox(
              height: 20,
            ),
            customTextField(1, "Kayıt No ", 10, _tibbiFormData.setKayitNo,
                isEmpty, _kayit, 80),
            customTextField(5, "Tıbbi İşlem Uygulama", 200,
                _tibbiFormData.setTibbiUygulama, isEmpty, _tibbiUygulama, 130),
          ],
        ),
      ),
    );
  }

  final TibbiFormData _tibbiFormData = TibbiFormData();
  late TibbiFormData? args;
  //late int? index;
  TibbiFormArguments? tibbiFormArguments;
  final _formKey = GlobalKey<FormState>();
  String _valueTibbiEtkilesimTuru = 'Gözlem';
  String _valueTibbiOrtam = 'Poliklinik';

  String? _selectedStajTuru;
  String? _selectedDoktor;
  final String hintTextStajTuru = "Staj Türü:";
  final String hintTextEtkilesim = "Etkileşim Türü:";
  final String hintTextOrtam = "Gerçekleştiği Ortam:";
  final String hintTextDoktor = "Klinik Eğitici:";
  final TextEditingController _kayit = TextEditingController();
  final TextEditingController _tibbiUygulama = TextEditingController();
  final TextEditingController _disKurum = TextEditingController();
  final TextEditingController _stajTuruController = TextEditingController();
  final TextEditingController _doktorController = TextEditingController();
  bool isLoading = false;

  void onChangedEtkilesim(String newVal) {
    if (tibbiFormArguments != null) {
      tibbiFormArguments?.tibbiFormData.setTibbiEtkilesimTuru(newVal);
    } else {
      setState(() {
        _valueTibbiEtkilesimTuru = newVal;
        _tibbiFormData.setTibbiEtkilesimTuru(newVal);
      });
    }
  }

  void onChangedOrtam(String newVal) {
    if (tibbiFormArguments != null) {
      tibbiFormArguments?.tibbiFormData.setTibbiOrtam(newVal);
    } else {
      setState(() {
        _valueTibbiOrtam = newVal;
        _tibbiFormData.setTibbiOrtam(newVal);
      });
    }
  }

  void formSakla() async {
    if (tibbiFormArguments != null) {
      setFormArgumentState();
      await _helper.updateTibbi(tibbiFormArguments!.tibbiFormData);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla güncellendi.');

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Drafts()));
    } else {
      setFormDataState();
      await _helper.insertTibbi(_tibbiFormData).then((value) {
        customSnackBar(context, 'Başarıyla taslağa kaydedildi');
      });
    }
  }

  void handleDelete() {
    setState(() {
      _helper.remove(tibbiFormArguments!.tibbiFormData.id);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla silindi');
      //  Navigator.pop(context, MaterialPageRoute(builder: (context) => Drafts()));
    });
  }

  void formIlet() async {
    if (tibbiFormArguments != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setFormArgumentState();
        bool res = await _dbHelper
            .insertTibbiFormToDatabase(tibbiFormArguments!.tibbiFormData);
        //    bool res = await _mySqlHelper.insertData(formArguments!.formData);
        if (res) {
          _helper.updateTibbi(tibbiFormArguments!.tibbiFormData);
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
        bool res = await _dbHelper
            .insertTibbiFormToDatabase(_tibbiFormData)
            .then((val) {
          setState(() {
            isLoading = false;
          });
          return val != null ? true : false;
        });
        print(_tibbiFormData.kayitNo);
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
    //fetch attending physician
    List<AttendingPhysician> attendingList =
        await _dbHelper.fetchAttendingPhysicians();
    List<String> attendingNames = [];
    for (AttendingPhysician item in attendingList) {
      attendingNames.add(item.attendingName);
    }
    //fetch stajTuru
    List<StajTuru> stajTuruList = await _dbHelper.fetchStajTuruTable();
    List<String> stajTurleri = [];
    for (StajTuru s in stajTuruList) {
      stajTurleri.add(s.stajTuru);
    }
    res.add(attendingNames);
    res.add(stajTurleri);
    return res;
  }

  void setFormArgumentState() {
    //textfield
    tibbiFormArguments?.tibbiFormData.setKayitNo(_kayit.text);
    tibbiFormArguments?.tibbiFormData.setDisKurum(_disKurum.text);
    tibbiFormArguments?.tibbiFormData.setTibbiUygulama(_tibbiUygulama.text);
    //typeahead
    tibbiFormArguments?.tibbiFormData.setStajTuru(_stajTuruController.text);
    tibbiFormArguments?.tibbiFormData.setDoktor(_doktorController.text);

    //other
    tibbiFormArguments?.tibbiFormData.setTarih();
    tibbiFormArguments?.tibbiFormData.setStatus('waiting');
  }

  void setFormDataState() {
    //typeahead
    _tibbiFormData.setStajTuru(_stajTuruController.text);
    _tibbiFormData.setDoktor(_doktorController.text);
    //dropdown
    _tibbiFormData.setTibbiEtkilesimTuru(_valueTibbiEtkilesimTuru);
    _tibbiFormData.setTibbiOrtam(_valueTibbiOrtam);

    //other
    _tibbiFormData.setTarih();
    _tibbiFormData.setStatus('waiting');
  }
}
