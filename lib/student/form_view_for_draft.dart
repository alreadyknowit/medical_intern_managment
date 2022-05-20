import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/PatientLog.dart';
import 'package:internship_managing_system/model/Speciality.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';
import 'package:internship_managing_system/student/widgets/CustomDropDown.dart';
import 'package:internship_managing_system/student/widgets/CustomTextField.dart';
import 'package:internship_managing_system/student/widgets/FilteringDropDown.dart';

import '/../shared/custom_spinkit.dart';
import '../../../model/AttendingPhysician.dart';
import '../../../model/Course.dart';
import '../../../model/Institute.dart';

class FormViewForDraft extends StatefulWidget {
  PatientLog form = PatientLog();
  FormViewForDraft({required this.form});
  @override
  State<FormViewForDraft> createState() => _HomePageState();
}

class _HomePageState extends State<FormViewForDraft> {
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
          children: const [
            ElevatedButton(onPressed: null, child: Text("Gönder"))
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
            FilteringDropDown(
                _patientLog,
                _patientLog.setInstute,
                _patientLog.setCourse,
                _patientLog.setSpeciality,
                _patientLog.setAttendingPhysician),
            CustomDropDown(
                map['ortam'], hintTextOrtam, _patientLog.setGerceklestigiOrtam),
            CustomDropDown(
                map['kapsam'], hintTextKapsam, _patientLog.setKapsam),
            CustomDropDown(map['etkilesim'], hintTextEtkilesim,
                _patientLog.setEtkilesimTuru),
            CustomDropDown(
                map['cinsiyet'], hintTextCinsiyet, _patientLog.setCinsiyet),
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
  late PatientLog? args;

  final _formKey = GlobalKey<FormState>();
  String _valueEtkilesim = 'Gözlem';
  String _valueKapsam = 'Öykü';
  String _valueOrtam = 'Poliklinik';
  String _valueCinsiyet = 'Kadın';
  final String hintTextCinsiyet = "Cinsiyet";
  final String hintTextStajTuru = "Staj Türü";
  final String hintTextEtkilesim = "Etkileşim Türü";
  final String hintTextKapsam = "Kapsam";
  final String hintTextOrtam = "Gerçekleştiği Ortam";
  final String hintTextDoktor = "Klinik Eğitici";
  final TextEditingController _kayit = TextEditingController();
  final TextEditingController _yas = TextEditingController();
  final TextEditingController _sikayet = TextEditingController();
  final TextEditingController _ayirici = TextEditingController();
  final TextEditingController _kesin = TextEditingController();
  final TextEditingController _tedavi = TextEditingController();
  final TextEditingController _stajTuruController = TextEditingController();
  final TextEditingController _doktorController = TextEditingController();

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

  handleDelete() {}

  void setFormDataState() {
    setState(() {
      _stajTuruController.text = "df";
    });
    //typeahead
    //_patientLog.setSpeciality(_stajTuruController.text as Speciality);
    // _patientLog.setAttendingPhysician(_doktorController.text as AttendingPhysician);
    //dropdown
    _patientLog.setEtkilesimTuru(_valueEtkilesim);
    _patientLog.setKapsam(_valueKapsam);
    //  _patientLog.setCinsiyet(_valueCinsiyet as Cinsiyet);
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
