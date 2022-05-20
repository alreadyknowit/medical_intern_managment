// /*
// import 'package:flutter/material.dart';
//
// import '../../arguments/form_args.dart';
// import '../../services/SQFLiteHelper.dart';
// import '../../services/StudentDatabaseHelper.dart';
// import '../../widgets/widgets.dart';
//
// class PatientLogFormScreen extends StatefulWidget {
//   const PatientLogFormScreen({Key? key}) : super(key: key);
//
//   @override
//   _PatientLogFormScreenState createState() => _PatientLogFormScreenState();
// }
//
// class _PatientLogFormScreenState extends State<PatientLogFormScreen> {
//   @override
//   initState() {
//     fetchFormContent();
//     super.initState();
//   }
//
//   final SQFLiteHelper _helper = SQFLiteHelper.instance;
//   final StudentDatabaseHelper _dbHelper = StudentDatabaseHelper();
//   late bool isDeletable;
//   final _formKey = GlobalKey<FormState>();
//   FormArguments? formArguments;
//   String _valueEtkilesim = 'Gözlem';
//   String _valueKapsam = 'Öykü';
//   String _valueOrtam = 'Poliklinik';
//   String? _selectedStajTuru;
//   String? _selectedDoktor;
//   String _valueCinsiyet = 'Erkek'; // initial value
//   final String hintTextCinsiyet = "Cinsiyet:";
//   final String hintTextStajTuru = "Staj Türü:";
//   final String hintTextEtkilesim = "Etkileşim Türü:";
//   final String hintTextKapsam = "Kapsam:";
//   final String hintTextOrtam = "Gerçekleştiği Ortam:";
//   final String hintTextDoktor = "Klinik Eğitici:";
//   final TextEditingController _kayit = TextEditingController();
//   final TextEditingController _yas = TextEditingController();
//   final TextEditingController _sikayet = TextEditingController();
//   final TextEditingController _ayirici = TextEditingController();
//   final TextEditingController _kesin = TextEditingController();
//   final TextEditingController _tedavi = TextEditingController();
//   final TextEditingController _stajTuruController = TextEditingController();
//   final TextEditingController _doktorController = TextEditingController();
//   bool isLoading = false;
//
//   @override
//   Widget build(BuildContext context) {
//     formArguments =
//         ModalRoute.of(context)?.settings.arguments as FormArguments?;
//
//     return Scaffold(
//       body: SafeArea(
//           child: FutureBuilder(
//               future: fetchFormContent(), //readJsonData(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return const Center(
//                       child: Text("Oops! Something went wrong."));
//                 } else if (snapshot.hasData) {
//                   var listOfContent = snapshot.data as List<List<String>>;
//                   var listOfStajTuru = listOfContent[1];
//                   var listOfDoktor = listOfContent[0];
//                   var listOfKapsam = [
//                     "Öykü",
//                     "Fizik Bakı",
//                     "Tanısal akıl Yürütme",
//                     "Teropötik akıl yürütme"
//                   ];
//                   var listOfOrtam = [
//                     "Poliklinik",
//                     "Servis",
//                     "Acil",
//                     "Ameliyathane",
//                     "Dış Kurum"
//                   ];
//                   var listOfEtkilesimTuru = [
//                     "Gözlem",
//                     "Yardımla yapma",
//                     "Yardımsız yapma",
//                     "Sanal olgu"
//                   ];
//                   var listOfCinsiyet = ['Erkek', 'Kadın', 'Diğer'];
//
//                   Map<String, dynamic> map = {
//                     'doktor': listOfDoktor,
//                     'etkilesim': listOfEtkilesimTuru,
//                     'kapsam': listOfKapsam,
//                     'ortam': listOfOrtam,
//                     'stajTuru': listOfStajTuru,
//                     'cinsiyet': listOfCinsiyet,
//                   };
//                   return isLoading ? spinkit : formWidget(map);
//                 } else {
//                   return Center(
//                     child: spinkit,
//                   );
//                 }
//               })),
//       bottomNavigationBar: SizedBox(
//         height: 44,
//         width: double.infinity,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             submitButton(Icons.send, context, "İLET", formIlet),
//             formArguments != null && isDeletable
//                 ? submitButton(Icons.delete, context, "SİL", handleDelete)
//                 : Container(),
//             submitButton(Icons.drafts_sharp, context, "SAKLA", formSakla),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Form formWidget(Map<String, dynamic> map) {
//     return Form(
//       key: _formKey,
//       child: SingleChildScrollView(
//         child: Column(
//           //  shrinkWrap: true,
//           children: [
//             customTypeAhead(map['stajTuru'], _stajTuruController,
//                 _selectedStajTuru, 'Staj Türü'),
//             customTypeAhead(
//                 map['doktor'], _doktorController, _selectedDoktor, 'Doktor'),
//             customDropDown(
//                 _valueOrtam, map['ortam'], hintTextOrtam, onChangedOrtam),
//             customDropDown(
//                 _valueKapsam, map['kapsam'], hintTextKapsam, onChangedKapsam),
//             customDropDown(_valueEtkilesim, map['etkilesim'], hintTextEtkilesim,
//                 onChangedEtkilesim),
//             customDropDown(_valueCinsiyet, map['cinsiyet'], hintTextCinsiyet,
//                 onChangedCinsiyet),
//             const SizedBox(
//               height: 20,
//             ),
//             customTextField(
//                 1, "Kayıt No ", 10, _formData.setKayitNo, isEmpty, _kayit, 80),
//             customTextField(
//                 1, "Hastanın Yaşı", 3, _formData.setYas, isNumeric, _yas, 80),
//             customTextField(
//                 1, "Şikayet", 10, _formData.setSikayet, isEmpty, _sikayet, 80),
//             customTextField(1, "Ayırıcı Tanı", 10, _formData.setAyiriciTani,
//                 isEmpty, _ayirici, 80),
//             customTextField(5, "Kesin Tanı", 50, _formData.setKesinTani,
//                 isEmpty, _kesin, 130),
//             customTextField(5, "Tedavi Yöntemi", 200,
//                 _formData.setTedaviYontemi, isEmpty, _tedavi, 130),
//           ],
//         ),
//       ),
//     );
//   }
// }
// */
