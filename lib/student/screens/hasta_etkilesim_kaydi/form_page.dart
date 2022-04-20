import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/model/Speciality.dart';

import '/../models/form_data.dart';
import '/../shared/custom_spinkit.dart';
import '../../../model/Course.dart';
import '../../../model/Institute.dart';
import '../../../shared/custom_alert.dart';
import '../../../shared/custom_snackbar.dart';
import '../../arguments/form_args.dart';
import '../../services/SQFLiteHelper.dart';
import '../../services/StudentDatabaseHelper.dart';
import '../../widgets/CustomDropDown.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/widgets.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);
  @override
  State<FormPage> createState() => _HomePageState();
}

class _HomePageState extends State<FormPage> {
  @override
  initState() {
    super.initState();
    fetchFormContent();
  }

  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
  late bool isDeletable;
  var choosenInstute = {};

  @override
  Widget build(BuildContext context) {
/*    formArguments =
    ModalRoute
        .of(context)
        ?.settings
        .arguments as FormArguments?;
    if (formArguments != null) {
      isDeletable = formArguments!.isDeletable ?? true;
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
    }*/

    return Scaffold(
      body: SafeArea(
          child: FutureBuilder(
              future: fetchFormContent(), //readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                      child: Text("Oops! Something went wrong."));
                } else if (snapshot.hasData) {
                  var listOfContent = snapshot.data as dynamic;
                  var courses = listOfContent[0];
                  var specialities = listOfContent[1];
                  var institutes = listOfContent[2];
                  var attendings = listOfContent[3];

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
                    'course': courses,
                    'etkilesim': listOfEtkilesimTuru,
                    'kapsam': listOfKapsam,
                    'ortam': listOfOrtam,
                    'specialities': specialities,
                    'institutes': institutes,
                    'attendings': attendings,
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
            /*  customTypeAhead(map['speciality'], _stajTuruController,
                _selectedStajTuru, 'Staj Türü'),
            customTypeAhead(
                map['doktor'], _doktorController, _selectedDoktor, 'Doktor'),*/
            CustomDropDown(
                map['institutes'], "Institutes", _patientLog.setInstute),
            CustomDropDown(map['course'], "Courses", _patientLog.setCourse),
            CustomDropDown(
                map['specialities'], "Speciality", _patientLog.setSpeciality),
            CustomDropDown(map['attendings'], "Attending Physicians",
                _patientLog.setAttendingPhysician),
            CustomDropDown(
                map['ortam'], hintTextOrtam, _patientLog.setGerceklestigiOrtam),
            CustomDropDown(
                map['kapsam'], hintTextKapsam, _patientLog.setKapsam),
            CustomDropDown(
                map['etkilesim'], hintTextOrtam, _patientLog.setEtkilesimTuru),
            CustomDropDown(
                map['cinsiyet'], hintTextOrtam, _patientLog.setCinsiyet),
            CustomTextField(1, "Kayıt No ", 10, _patientLog.setKayitNo, 80),
            CustomTextField(1, "Hastanın Yaşı", 3, _patientLog.setYas, 80),
            CustomTextField(1, "Şikayet", 10, _patientLog.setSikayet, 80),
            CustomTextField(
                1, "Ayırıcı Tanı", 10, _patientLog.setAyiriciTani, 80),
            CustomTextField(5, "Kesin Tanı", 50, _patientLog.setKesinTani, 130),
            CustomTextField(
                5, "Tedavi Yöntemi", 200, _patientLog.setTedaviYontemi, 130),
          ],
        ),
      ),
    );
  }

  final PatientLog _patientLog = PatientLog();
  late FormData? args;

  FormArguments? formArguments;
  final _formKey = GlobalKey<FormState>();

  final String hintTextCinsiyet = "Cinsiyet";
  final String hintTextStajTuru = "Staj Türü";
  final String hintTextEtkilesim = "Etkileşim Türü";
  final String hintTextKapsam = "Kapsam";
  final String hintTextOrtam = "Gerçekleştiği Ortam";
  final String hintTextDoktor = "Klinik Eğitici";
  bool isLoading = false;

  Future<List<List<dynamic>>> fetchFormContent() async {
    List<List<dynamic>> res = [];
    List<AttendingPhysician> attendings =
        await _dbHelper.fetchAttendingPhysicians();
    List<Course> courses = await _dbHelper.fetchCourses();
    List<Speciality> speciality = await _dbHelper.fetchSpeciality();
    List<Institute> institute = await _dbHelper.fetchInstitute();

    res.add(courses);
    res.add(speciality);
    res.add(institute);
    res.add(attendings);

    return res;
  }

  //TODO: methodları doldur
  formIlet() async {
    await _dbHelper.insertFormToDatabase1(_patientLog);
    bool res = await _dbHelper.insertFormToDatabase1(_patientLog);
    if (res) {
      _helper.update(formArguments!.formData);
      customSnackBar(context, 'Başarıyla gönderildi');
    } else {
      errorAlert(context);
    }
  }

  handleDelete() {}
  formSakla() {}

  /*




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

  void formIlet() async {
    if (formArguments != null) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setFormArgumentState();
        bool res =
        await _dbHelper.insertFormToDatabase(formArguments!.formData);
        //    bool res = await _mySqlHelper.insertData(formArguments!.formData);
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
        bool res = await _dbHelper.insertFormToDatabase(_formData).then((val) {
          setState(() {
            isLoading = false;
          });
          return val != null ? true : false;
        });
        print(_formData.kayitNo);
        if (res) {
          customSnackBar(context, 'Başarıyla gönderildi');
        } else {
          errorAlert(context);
        }
      }
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
*/
/*  void setFormArgumentState() {
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
}*/
}
