import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/student/widgets/FilteringDropDown.dart';

import '/../shared/custom_spinkit.dart';
import '../../../model/AttendingPhysician.dart';
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

  @override
  Widget build(BuildContext context) {
    formArguments =
        ModalRoute.of(context)?.settings.arguments as FormArguments?;
    print(formArguments);
    if (formArguments != null) {
      isDeletable = formArguments!.isDeletable ?? true;
      args = formArguments?.formData as PatientLog?;
      //  index = formArguments?.index;
      //textField
      _kayit.text = args!.kayitNo.toString();
      _yas.text = args!.yas.toString();
      _sikayet.text = args!.sikayet.toString();
      _ayirici.text = args!.ayiriciTani.toString();
      _kesin.text = args!.kesinTani.toString();
      _tedavi.text = args!.tedaviYontemi.toString();

      //dropdown
      _valueCinsiyet = args!.cinsiyet.toString();
      _doktorController.text = args!.attendingPhysician.toString();
      _valueEtkilesim = args!.etkilesimTuru.toString();
      _valueKapsam = args!.kapsam.toString();
      _valueOrtam = args!.gerceklestigiOrtam.toString();
      _stajTuruController.text = args!.speciality.toString();
      _instituteController.text = args!.instute.toString();
      _courseController.text = args!.course.toString();
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

  Widget formWidget(Map<String, dynamic> map) {
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            /*customTypeAhead(map['speciality'], _stajTuruController,
                _selectedStajTuru, 'Staj Türü'),
            customTypeAhead(
                map['doktor'], _doktorController, _selectedDoktor, 'Doktor'),*/

            FilteringDropDown(1, _patientLog.setInstute, _patientLog.setCourse,
                _patientLog.setSpeciality, _patientLog.setAttendingPhysician),
            CustomDropDown(
                map['ortam'], "Ortam", _patientLog.setGerceklestigiOrtam),
            CustomDropDown(map['kapsam'], "Kapsam", _patientLog.setKapsam),
            CustomDropDown(map['etkilesim'], "Etkileşim Türü",
                _patientLog.setEtkilesimTuru),
            CustomDropDown(
                map['cinsiyet'], "Cinsiyet", _patientLog.setCinsiyet),
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

  void onChangedInstitute(Institute newVal) {
    setState(() {
      _patientLog.setInstute(newVal);
    });
  }

  final PatientLog _patientLog = PatientLog();
  late PatientLog? args;

  late FormArguments? formArguments;
  final _formKey = GlobalKey<FormState>();
  String _valueEtkilesim = 'Gözlem';
  String _valueKapsam = 'Öykü';
  String _valueOrtam = 'Poliklinik';
  String _valueCinsiyet = 'Kadın';

  final TextEditingController _kayit = TextEditingController();
  final TextEditingController _yas = TextEditingController();
  final TextEditingController _sikayet = TextEditingController();
  final TextEditingController _ayirici = TextEditingController();
  final TextEditingController _kesin = TextEditingController();
  final TextEditingController _tedavi = TextEditingController();
  final TextEditingController _stajTuruController = TextEditingController();
  final TextEditingController _doktorController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

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
    bool res = await _dbHelper.insertFormToDatabase(_patientLog);
    if (res) {
      _helper.update(formArguments!.formData);
      customSnackBar(context, 'Başarıyla gönderildi');
    } else {
      errorAlert(context);
    }
  }

  handleDelete() {}

  void formSakla() async {
    if (formArguments?.formData != null) {
      setFormArgumentState();
      await _helper.update(formArguments!.formData);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla güncellendi.');

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Drafts()));
    } else {
      setFormDataState();
      await _helper.insert(_patientLog).then((value) {
        customSnackBar(context, 'Başarıyla taslağa kaydedildi');
      });
    }
  }

  void setFormArgumentState() {
    formArguments?.formData.setKayitNo(_kayit.text);
    formArguments?.formData.setYas(_yas.text);
    formArguments?.formData.setSikayet(_sikayet.text);
    formArguments?.formData.setAyiriciTani(_ayirici.text);
    formArguments?.formData.setKesinTani(_kesin.text);
    formArguments?.formData.setTedaviYontemi(_tedavi.text);

    //typeahead
    formArguments?.formData
        .setSpeciality(_stajTuruController.text as Speciality);
    formArguments?.formData
        .setAttendingPhysician(_doktorController.text as AttendingPhysician);
    formArguments?.formData.setCourse(_courseController.text as Course);
    formArguments?.formData.setInstute(_instituteController.text as Institute);

    //other
    formArguments?.formData.createdAt;
    formArguments?.formData.setStatus('waiting');
  }

  void setFormDataState() {
    //typeahead
    /*_patientLog.setSpeciality(_stajTuruController.text as Speciality);
    _patientLog
        .setAttendingPhysician(_doktorController.text as AttendingPhysician);
    _patientLog.setCourse(_courseController.text as Course);
    _patientLog.setInstute(_instituteController.text as Institute);*/
    //dropdown
    _patientLog.setEtkilesimTuru(_valueEtkilesim);
    _patientLog.setKapsam(_valueKapsam);
    //_patientLog.setCinsiyet(_valueCinsiyet as Cinsiyet);
    _patientLog.setGerceklestigiOrtam(_valueOrtam);

    //other
    //_patientLog.setCreatedAt(1,1,1999);
    _patientLog.setStatus('waiting');
  }
}

/*






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
