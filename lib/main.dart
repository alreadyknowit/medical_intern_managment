import 'package:flutter/material.dart';
import 'form_data.dart';
import 'constants.dart';

void main() {
  runApp(const InternshipManagingSystem());
}

class InternshipManagingSystem extends StatelessWidget {
  const InternshipManagingSystem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _valueEtkilesim = "Gözlem";
  String _valueKapsam = "Öykü";
  String _valueOrtam = "Poliklinik";
  String _valueDoktor = "Esra Demir";
  String _valueStajTuru = "Ortopedi";
  String _valueCinsiyet = "Diğer";
  final String hintTextCinsiyet = "Cinsiyet:";
  final String hintTextStajTuru = "Staj Türü:";
  final String hintTextEtkilesim = "Etkileşim Türü:";
  final String hintTextKapsam = "Kapsam:";
  final String hintTextOrtam = "Gerçekleştiği Ortam:";
  final String hintTextDoktor = "Klinik Eğitici:";

  void onChangedCinsiyet(String? newVal) {
    setState(() {
      _valueCinsiyet = newVal!;
    });
  }

  void onChangedStajTuru(String? newVal) {
    setState(() {
      _valueStajTuru = newVal!;
    });
  }

  void onChangedEtkilesim(String? newVal) {
    setState(() {
      _valueEtkilesim = newVal!;
    });
  }

  void onChangedKapsam(String? newVal) {
    setState(() {
      _valueKapsam = newVal!;
    });
  }

  void onChangedOrtam(String? newVal) {
    setState(() {
      _valueOrtam = newVal!;
    });
  }

  void onChangedDoktor(String? newVal) {
    setState(() {
      _valueDoktor = newVal!;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> _cinsiyetItems = [
      "Erkek",
      "Kadın",
      "Diğer",
    ];
    List<String> _stajTuruItems = [
      "Ortopedi",
      "Kardiyoloji",
      "Dermatoloji",
      "Pediatri"
    ];
    List<String> _etkilesimTuruItems = [
      "Gözlem",
      "Yardımla yapma",
      "Yardımsız yapma",
      "Sanal olgu"
    ];
    List<String> _kapsamItems = [
      "Öykü",
      "Fizik Bakı",
      "Tanısal akıl Yürütme",
      "Teropötik akıl yürütme"
    ];
    List<String> _ortamItems = [
      "Poliklinik",
      "Servis",
      "Acil",
      "Ameliyathane",
      "Dış Kurum"
    ];
    List<String> _doktorItems = [
      "Esra Demir",
      "Mehmet Uçar",
      "Kemal Yurdakul",
      "Fehmi Öztürk",
      "Mehmet Öz"
    ];
    return Scaffold(
      backgroundColor: const Color(0xffC9A7E3),
      appBar: AppBar(
        //  backgroundColor: Colors.teal.shade400,
        title: const Text('Hasta Etkileşim Kaydı'),
        centerTitle: true,
        backgroundColor: const Color(0xffB27FDA),
        elevation: 0,
      ),
      body: SafeArea(
          child: Center(
        child: ListView(
          children: [
            myTextFieldRow("Kayıt No: ", 10),
            myDropDownContainer(_valueStajTuru, _stajTuruItems,
                hintTextStajTuru, onChangedStajTuru),
            myDropDownContainer(
                _valueDoktor, _doktorItems, hintTextDoktor, onChangedDoktor),
            myTextFieldRow("Hastanın Yaşı:", 3),
            myDropDownContainer(_valueCinsiyet, _cinsiyetItems,
                hintTextCinsiyet, onChangedCinsiyet),
            myTextFieldRow("Şikayet:", 50),
            myTextFieldRow("Ayırıcı Tanı:", 50),
            myTextFieldRow("Kesin Tanı:", 50),
            myTextFieldRow("Tedavi Yöntemi:", 100),
            myDropDownContainer(_valueEtkilesim, _etkilesimTuruItems,
                hintTextEtkilesim, onChangedEtkilesim),
            myDropDownContainer(
                _valueKapsam, _kapsamItems, hintTextKapsam, onChangedKapsam),
            myDropDownContainer(
                _valueOrtam, _ortamItems, hintTextOrtam, onChangedOrtam),
           const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
            width: 150,
                  height: 50,
                  child: TextButton(

                    onPressed: () {
                      setState(() {

                      });
                    },
                    child: Text(
                      "GÖNDER",
                      style: kTextStyle.copyWith(fontSize: 20),
                    ),
                    style: ButtonStyle(


                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xff4F4DBB),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }

  Row myTextFieldRow(String text, int? maxLength) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          text,
          style: kTextStyle,
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: TextField(
            focusNode: FocusNode(),
            autofocus: false,
            style: kTextStyle,
            maxLength: maxLength,
            maxLines: null,
            decoration: InputDecoration(
              border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              //labelText: text,
              labelStyle:
                  kTextStyle.copyWith(fontSize: 12, color: Colors.white54),
            ),
          ),
        ),
      ],
    );
  }

  Container myDropDownContainer(
      String initialVal, List<String> listItems, String text, Function myFunc) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: kTextStyle,
          ),
          const SizedBox(
            width: 12,
          ),
          Center(
            child: Align(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(3)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: false,
                    onTap: () => myFunc(initialVal),
                    borderRadius: BorderRadius.circular(5),
                    value: initialVal,
                    icon: const Icon(
                      Icons.arrow_downward,
                      color: Colors.black38,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    dropdownColor: Colors.white,
                    style: kTextStyle.copyWith(color: Colors.black),
                    onChanged: (val) => myFunc(val),
                    items:
                        listItems.map<DropdownMenuItem<String>>((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                          style: kTextStyle.copyWith(color: Colors.black),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
