import 'package:flutter/material.dart';
import 'package:internship_managing_system/arguments/form_args.dart';
import 'package:internship_managing_system/constants.dart';
import 'package:internship_managing_system/models/form_data.dart';
import 'package:internship_managing_system/models/form_add.dart';
import 'package:internship_managing_system/student/form_page.dart';
import 'package:provider/provider.dart';
import 'form_view.dart';

class Drafts extends StatefulWidget {
  @override
  State<Drafts> createState() => _DraftsState();
}

class _DraftsState extends State<Drafts> {
  @override
  Widget build(BuildContext context) {

    void pushToFormPage(FormData formData) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => FormView()));
    }

     void deleteFormInstance(int index){
      setState(() {
        Provider.of<FormAdd>(context, listen: false).deleteFormInstance(index);
      });
    }
    List<FormData> _forms = Provider.of<FormAdd>(context).getForms();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Taslaklar"),
        centerTitle: true,
      ),
      body: ListView.separated(
        separatorBuilder: (BuildContext context, int index) => const Divider(
          height: 5,
          color: Colors.blueAccent,
        ),
        itemCount: _forms.length,
        itemBuilder: (BuildContext context, int index) {

          return studentListViewInstanceContainer(
              const Color.fromARGB(200, 200, 130, 240),
              pushToFormPage,
              _forms[index],
              context,index, deleteFormInstance);
        },
      ),
    );
  }
}

GestureDetector studentListViewInstanceContainer(Color color, Function function, FormData formData, BuildContext context, int index, void Function(int) delete) {
  return GestureDetector(
    onTap: () => function(formData),
    child: Container(
      height: 100,
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Kayıt No: ${formData.getKayitNo()}',
                style: kTextStyle,
              ),
              Text(
                'Tarih: ${formData.getKayitNo()}',
                style: kTextStyle.copyWith(fontSize: 15),
              ) //TODO: implement DateT
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const FormPage(),
                      settings: RouteSettings(
                        arguments: FormArguments(index: index, formData: formData),
                      ),
                    ),
                  );
                },
                child: const Text('Düzenle'),
              ),
              const SizedBox(
                width: 5,
              ),
              ElevatedButton(
                onPressed:()=>delete(index),
                child: const Text('Sil'),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
