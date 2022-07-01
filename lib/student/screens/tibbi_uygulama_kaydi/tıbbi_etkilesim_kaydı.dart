import 'package:flutter/material.dart';
import 'package:internship_managing_system/model/AttendingPhysician.dart';
import 'package:internship_managing_system/model/ProcedureLog.dart';
import 'package:internship_managing_system/shared/custom_spinkit.dart';
import 'package:internship_managing_system/student/arguments/form_args.dart';
import 'package:internship_managing_system/student/services/SQFLiteHelper.dart';
import 'package:internship_managing_system/student/services/StudentDatabaseHelper.dart';
import 'package:internship_managing_system/student/widgets/CustomDropDown.dart';
import 'package:internship_managing_system/student/widgets/FilteringDropDown.dart';

import '../../../model/Course.dart';
import '../../../model/Institute.dart';
import '../../../model/Speciality.dart';
import '../../../shared/custom_alert.dart';
import '../../../shared/custom_snackbar.dart';
import '../../widgets/CustomTextField.dart';
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
      _kayitController.text = args!.kayitNo.toString();

      //dropdown
      _valueTibbiOrtam = args!.gerceklestigiOrtam.toString();
      _valueTibbiEtkilesimTuru = args!.etkilesimTuru.toString();
      //

      _doktorController.text = args!.attendingPhysician.toString();
      _disKurumController.text = args!.disKurum.toString();
      _tibbiUygulamaController.text = args!.tibbiUygulama.toString();
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
                    'course': courses,
                    'etkilesim': listOfEtkilesimTuru,
                    'ortam': listOfOrtam,
                    'specialities': specialities,
                    'institutes': institutes,
                    'attendings': attendings,
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
            FilteringDropDown(
                2,
                _procedureLog.setInstute,
                _procedureLog.setCourse,
                _procedureLog.setSpeciality,
                _procedureLog.setAttendingPhysician),
            /*CustomDropDown(map['etkilesim'], " Etkileşim Türü",
                _procedureLog.setEtkilesimTuru),
            CustomDropDown(map['ortam'], " Gerçekleştiği Ortam",
                _procedureLog.setGerceklestigiOrtam),
            CustomTextField(_instituteController,1, "Lütfen Dış Kurumu Yazınız", 10,
                _procedureLog.setDisKurum, 80),*/
            const SizedBox(
              height: 20,
            ),
            CustomTextField(_kayitController,1, "Kayıt No ", 10, _procedureLog.setKayitNo, 80),
            CustomTextField(_kayitController,5, "Tıbbi İşlem Uygulama", 200,
                _procedureLog.setTibbiUygulama, 130),
          ],
        ),
      ),
    );
  }

  final ProcedureLog _procedureLog = ProcedureLog();
  late ProcedureLog? args;
  //late int? index;

  TibbiFormArguments? tibbiFormArguments;
  final _formKey = GlobalKey<FormState>();
  String _valueTibbiEtkilesimTuru = 'Gözlem';
  String _valueTibbiOrtam = 'Poliklinik';

  final TextEditingController _kayitController = TextEditingController();
  final TextEditingController _tibbiUygulamaController = TextEditingController();
  final TextEditingController _disKurumController = TextEditingController();
  final TextEditingController _stajTuruController = TextEditingController();
  final TextEditingController _doktorController = TextEditingController();
  final TextEditingController _instituteController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  bool isLoading = false;
  /*formSakla() {}
  formIlet() {}
  handleDelete() {}*/

  void formSakla() async {
    if (tibbiFormArguments != null) {
      setFormArgumentState();
      await _helper.updateTibbi(tibbiFormArguments!.tibbiFormData);
      Navigator.pop(context);
      customSnackBar(context, 'Başarıyla güncellendi.');

      //Navigator.pushReplacement(context, MaterialPageRoute(builder: (builder)=>Drafts()));
    } else {
      setFormDataState();
      await _helper.insertTibbi(_procedureLog).then((value) {
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
            .insertTibbiFormToDatabase(_procedureLog)
            .then((val) {
          setState(() {
            isLoading = false;
          });
          return val != null ? true : false;
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

  void setFormArgumentState() {
    //textfield
    tibbiFormArguments?.tibbiFormData.setKayitNo(_kayitController.text);
    tibbiFormArguments?.tibbiFormData.setDisKurum(_disKurumController.text);
    tibbiFormArguments?.tibbiFormData.setTibbiUygulama(_tibbiUygulamaController.text);
    //typeahead

    tibbiFormArguments?.tibbiFormData
        .setSpeciality(_stajTuruController.text as Speciality);
    tibbiFormArguments?.tibbiFormData
        .setAttendingPhysician(_doktorController.text as AttendingPhysician);
    tibbiFormArguments?.tibbiFormData
        .setCourse(_courseController.text as Course);
    tibbiFormArguments?.tibbiFormData
        .setInstute(_instituteController.text as Institute);

    //other
    tibbiFormArguments?.tibbiFormData.createdAt;
    tibbiFormArguments?.tibbiFormData.setStatus('waiting');
  }

  final berlinWallFell =
      DateTime.utc(1989, 11, 9); // TODO: Date time eklenecek..!
  void setFormDataState() {
    //typeahead

    _procedureLog
        .setAttendingPhysician(_doktorController.text as AttendingPhysician);
    _procedureLog.setSpeciality(_stajTuruController.text as Speciality);
    _procedureLog.setCourse(_courseController.text as Course);
    _procedureLog.setInstute(_instituteController.text as Institute);
    //dropdown
    _procedureLog.setEtkilesimTuru(_valueTibbiEtkilesimTuru);
    _procedureLog.setGerceklestigiOrtam(_valueTibbiOrtam);

    //other
    _procedureLog.setCreatedAt(berlinWallFell);
    _procedureLog.setStatus('waiting');
  }
}
