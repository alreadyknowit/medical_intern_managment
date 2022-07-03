
import 'package:flutter/material.dart';
import '../../../model/Speciality.dart';
import 'package:internship_managing_system/student/widgets/FilteringDropDown.dart';
import '../../../model/PatientLog.dart';
import '/../shared/custom_spinkit.dart';
import '../../../model/AttendingPhysician.dart';
import '../../../model/Course.dart';
import '../../../model/Institute.dart';
import '../../../shared/custom_alert.dart';
import '../../../shared/custom_snackbar.dart';
import '../../services/SQFLiteHelper.dart';
import '../../services/StudentDatabaseHelper.dart';
import '../../widgets/CustomDropDown.dart';
import '../../widgets/CustomTextField.dart';
import '../../widgets/widgets.dart';

class ShowDraft extends StatefulWidget {
  PatientLog? patientLogFromDraft;

  ShowDraft({this.patientLogFromDraft});

  @override
  State<ShowDraft> createState() => _HomePageState();
}

class _HomePageState extends State<ShowDraft> {

  final SQFLiteHelper _helper = SQFLiteHelper.instance;
  final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
  late bool isDeletable;

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
          children: [
            submitButton(Icons.send, context, "İLET", formIlet),
            submitButton(Icons.drafts_sharp, context, "GÜNCELLE", formGuncelle),
            submitButton(Icons.drafts_sharp, context, "SİL", formSil),
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
                1,
                patientLog.setInstute,
                patientLog.setCourse,
                patientLog.setSpeciality,
                patientLog.setAttendingPhysician),
            CustomDropDown(patientLog.gerceklestigiOrtam,
                map['ortam'], "Ortam", patientLog.setGerceklestigiOrtam),
            CustomDropDown(patientLog.kapsam,map['kapsam'], "Kapsam", patientLog.setKapsam),
            CustomDropDown(patientLog.etkilesimTuru,map['etkilesim'], "Etkileşim Türü",
                patientLog.setEtkilesimTuru),
            CustomDropDown("Erkek",map['cinsiyet'], "Cinsiyet", patientLog.setCinsiyet),
            CustomTextField(_kayitController,1, "Kayıt No ", 10, patientLog.setKayitNo, 80),
            CustomTextField(_yasContoller,1, "Hastanın Yaşı", 3, patientLog.setYas, 80),
            CustomTextField(_sikayetController,1, "Şikayet", 10, patientLog.setSikayet, 80),
            CustomTextField(
                _ayiriciTaniController,1, "Ayırıcı Tanı", 10, patientLog.setAyiriciTani, 80),
            CustomTextField(_kesinTaniController,5, "Kesin Tanı", 50, patientLog.setKesinTani, 130),
            CustomTextField(_tedaviController,
                5, "Tedavi Yöntemi", 200, patientLog.setTedaviYontemi, 130),
          ],
        ),
      ),
    );
  }
  final TextEditingController _kayitController = TextEditingController();
  final TextEditingController _sikayetController = TextEditingController();
  final TextEditingController _yasContoller = TextEditingController();
  final TextEditingController _ayiriciTaniController = TextEditingController();
  final TextEditingController _kesinTaniController = TextEditingController();
  final TextEditingController _tedaviController = TextEditingController();
  PatientLog patientLog = PatientLog();
  late PatientLog? args;

  final _formKey = GlobalKey<FormState>();

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
    fillContent();

    return res;
  }

  void fillContent(){
    PatientLog? draftedLog = widget.patientLogFromDraft;
    if(draftedLog != null){

      //dropdown
      patientLog.setId(draftedLog.id);
      patientLog.setKapsam(draftedLog.kapsam);
      patientLog.setInstute(draftedLog.institute);
      patientLog.setCinsiyet(draftedLog.cinsiyet);
      patientLog.setCourse(draftedLog.course);
      patientLog.setSpeciality(draftedLog.speciality);
      patientLog.setCoordinator(draftedLog.coordinator);
      patientLog.setAttendingPhysician(draftedLog.attendingPhysician);
      patientLog.setStudent(draftedLog.student);
      patientLog.setGerceklestigiOrtam(draftedLog.gerceklestigiOrtam);
      patientLog.setEtkilesimTuru(draftedLog.etkilesimTuru);

      //text
      patientLog.setSikayet(draftedLog.sikayet);
      _sikayetController.text=draftedLog.sikayet ?? "";

      patientLog.setYas(draftedLog.yas);
      _yasContoller.text=draftedLog.yas ?? "";

      patientLog.setAyiriciTani(draftedLog.ayiriciTani);
      _ayiriciTaniController.text =draftedLog.ayiriciTani ?? "";

      patientLog.setKesinTani(draftedLog.kesinTani);
      _kesinTaniController.text = draftedLog.kesinTani ?? "";

      patientLog.setAyiriciTani(draftedLog.tedaviYontemi);
      _tedaviController.text = draftedLog.tedaviYontemi ?? "";

      patientLog.setKayitNo(draftedLog.kayitNo);
      _kayitController.text=draftedLog.kayitNo ?? "";

    }
  }
  formSil() async {
   int res =  await _helper.remove(patientLog.id).then((value) {
     Navigator.pop(context);
     return value;
   });
   if(res==1){
     setState(() {
       customSnackBar(context, 'Başarıyla silindi');
     });
   }

  }

  formIlet() async {
    bool res = await _dbHelper.insertFormToDatabase(patientLog);
    res == true
        ? customSnackBar(context, 'Başarıyla gönderildi')
        : errorAlert(context);
  }

  void formGuncelle() async {
    int? id = patientLog.id;
    int res=0;
    if(id != null){
       res = await _helper.update(patientLog);
    }
    res != 1
        ? errorAlert(context)
        : customSnackBar(context, 'Başarıyla taslağa kaydedildi');
  }
}
